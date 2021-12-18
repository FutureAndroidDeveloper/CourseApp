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
        updateState()
    }
    
    func durationTimePicked(_ time: DurationTime) {
        duration = TaskDurationModel(durationTime: time)
        update()
    }
    
    func saveDidTapped() {
        runtimeModel()
    }
    
    
    private func runtimeModel() {
        print(#function)
        print()
        
        guard let model = constructor.model else {
            return
        }
        
        let name = model.nameModel.fieldModel.value
        print("name = \(name)")
        
        let freq = model.frequencyModel.initialFrequency
        print("freq = \(freq)")
        
        let days = model.weekdayModel?.weekdayModels.compactMap { $0 }
        let daysResult = days?.map { $0.isSelected }
            .map { $0 ? "1" : "0" }
            .joined()
        print("daysResult = \(daysResult)")
        
        let onceDate = model.selectDateModel?.date.value
        print("Once date = \(onceDate)")
        
        let period = model.periodModel
        let start = period?.start.value
        let end = period?.end.value
        let isInfinite = period?.isInfiniteModel.isSelected
        print("start = \(start)")
        print("end = \(end)")
        print("isInfinite = \(isInfinite)")
        
        let notifcations = model.notificationModel.notificationModels
        notifcations.forEach { print("\($0.hourModel.value) : \($0.minModel.value)") }
        
        let sanction = model.sanctionModel.model.value
        print("sanction = \(sanction)")
//
//        if let repeatModel = model as? RepeatCreateTaskModel {
//            let name = repeatModel.nameModel.fieldModel.value
//        }
        
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
    
    func getPeriodModel() -> TaskPeriodModel {
        // TODO: - получать isSelected, даты из модели задачи
        
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечная длительность курса", isSelected: false)
        return TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: DateFieldModel(), end: DateFieldModel(value: nil))
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
        // TODO: - получать нотификации из модели задачи
        
        let model = NotificationTaskTimeModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                              minModel: TimeBlockModelFactory.getMinModel())
        return [model]
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
