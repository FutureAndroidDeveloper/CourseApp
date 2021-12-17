import Foundation
import XCoordinator


class CreateTaskViewModelImpl: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {

    private let router: UnownedRouter<TasksRoute>
    private let taskType: ATYTaskType
    private var taskModel: ATYUserTask!
    
    private lazy var constructor: TaskCreationModel = {
        return TaskCreationModel(type: self.taskType, delegate: self)
    }()
    
    private var notificationModels: [NotificationTaskTimeModel] = []
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    private var duration: TaskDurationModel?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    

    init(taskType: ATYTaskType, router: UnownedRouter<TasksRoute>) {
        self.taskType = taskType
        self.router = router
        update()
    }
    
    func notificationTimePicked(_ time: NotificationTime) {
        guard let notificationDelegate = notificationDelegate else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: time)
        notificationDelegate.notificationDidAdd(model)
        notificationModels = notificationDelegate.getNotificationModels()
        updateState()
    }
    
    func durationTimePicked(_ time: DurationTime) {
        duration = TaskDurationModel(durationTime: time)
        update()
    }
    
}


extension CreateTaskViewModelImpl: TaskCreationDelegate {
    
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?) {
        notificationDelegate = delegate
        router.trigger(.timePicker(type: pickerType))
    }
    
    func getNameModel() -> TextFieldModel {
        // TODO: - получать имя из модели задачи
        
        return .init(value: String(), placeholder: R.string.localizable.forExampleDoExercises())
    }
    
    func getFrequncy() -> ATYFrequencyTypeEnum {
        // TODO: - получать частоту из модели задачи
        
        return .EVERYDAY
    }
    
    func getOnceDateModel() -> DateFieldModel {
        // TODO: - получать дату из модели задачи
        
        return DateFieldModel()
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        // TODO: - получать описание из модели задачи
        
        return PlaceholderTextViewModel(text: nil, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> NaturalNumberFieldModel {
        // TODO: - получать кол-во из модели задачи
        
        return NaturalNumberFieldModel()
    }
    
    func getPeriodModel() -> (start: DateFieldModel, end: DateFieldModel) {
        // TODO: - получать даты из модели задачи
        
        return (DateFieldModel(), DateFieldModel())
    }
    
    func getDurationModel() -> TaskDurationModel {
        // TODO: - получать длительность из модели задачи
        if let durationModel = self.duration {
            return durationModel
        } else {
            let model = TaskDurationModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                          minModel: TimeBlockModelFactory.getMinModel(),
                                          secModel: TimeBlockModelFactory.getSecModel())
            duration = model
            return model
        }
    }
    
    func getNotificationModels() -> [NotificationTaskTimeModel] {
        if notificationModels.isEmpty {
            let model = NotificationTaskTimeModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                                  minModel: TimeBlockModelFactory.getMinModel())
            notificationModels.append(model)
        }
        return notificationModels
    }
    
    func getWeekdayModels() -> [WeekdayModel] {
        // TODO: - получать модели из модели задачи или создавать новые из календаря
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        return orderedSymbols.map { WeekdayModel(title: $0) }
    }
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        data.value = constructor.getModel()
    }
    
    /**
     Обновление внутри ячеек.
     
     Приводит к вызову tableView.beginUpdates()
     */
    func updateState() {
        updatedState.value = ()
    }
    
}
