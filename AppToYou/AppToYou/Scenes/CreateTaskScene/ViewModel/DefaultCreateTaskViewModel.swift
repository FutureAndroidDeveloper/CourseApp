import Foundation
import XCoordinator


class DefaultCreateTaskViewModel: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {
    private(set) var router: UnownedRouter<TasksRoute>

    
    private lazy var constructor: DefaultTaskModel = {
        return DefaultTaskModel(delegate: self)
    }()

    weak var notificationDelegate: TaskNoticationDelegate?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    private let type: ATYTaskType
    private let taskService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    var taskRequest: UserTaskCreateRequest?


    init(type: ATYTaskType, router: UnownedRouter<TasksRoute>) {
        self.type = type
        self.router = router
        update()
    }
    
    func notificationPicked(_ notification: NotificationTime) {
        guard let notificationDelegate = notificationDelegate else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: notification)
        notificationDelegate.notificationDidAdd(model)
        updateState()
    }
    
    func durationPicked(_ duration: DurationTime) {
        // обработка получения происходит в TimerCreateTaskViewModel
    }
    
    private func saveModel() {
        guard let task = taskRequest else {
            print("Task Request Is NIL!")
            return
        }
        print()
        print("trying to save")
        print(task)
        
        taskService.create(task: task) { result in
            switch result {
            case .success(let newTask):
                print()
                print("NEW TASK created")
                print(newTask)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func saveDidTapped() {
        validate()
        saveModel()
    }
    
    func validate() {
        print(#function)
        print()
        
        let model = constructor.model
        
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = Int32(model.sanctionModel.model.value)

        let startPeriod = model.periodModel?.start.value
        let startOnce = model.selectDateModel?.date.value
        
        guard let startDate = startPeriod ?? startOnce else {
            print("NEED to set start date")
            return
        }
        
        let start = startDate.toString(dateFormat: .localeYearDate)
        let end = model.periodModel?.end.value?.toString(dateFormat: .localeYearDate)
        let isInfinite = model.periodModel?.isInfiniteModel.isSelected ?? false
        
        let reminders = model.notificationModel.notificationModels
            .map { "\($0.hourModel.value):\($0.minModel.value)" }
        
        let days = model.weekdayModel?.weekdayModels
            .compactMap { $0 }
            .map { $0.isSelected ? "1" : "0" }
            .joined()

        taskRequest = UserTaskCreateRequest(
            taskName: name, taskType: type, frequencyType: freq, taskSanction: sanction,
            infiniteExecution: isInfinite, startDate: start, endDate: end, daysCode: days,
            taskDescription: nil, reminderList: reminders, taskAttribute: nil)
    }
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        data.value = constructor.getModels()
    }
    
    /**
     Обновление внутри ячеек.
     
     Приводит к вызову tableView.beginUpdates()
     */
    func updateState() {
        updatedState.value = ()
    }

}

extension DefaultCreateTaskViewModel: DefaultTaskCreationDelegate {
    
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?) {
        notificationDelegate = delegate
        router.trigger(.timePicker(type: pickerType))
    }
    
    func getNameModel() -> TextFieldModel {
        // TODO: - получать имя из модели задачи
        
        return .init(value: String(), placeholder: R.string.localizable.forExampleDoExercises())
    }
    
    func getFrequncy() -> FrequncyValueModel {
        // TODO: - получать частоту из модели задачи
        
        return FrequncyValueModel()
    }
    
    func getPeriodModel() -> TaskPeriodModel {
        // TODO: - получать isSelected, даты из модели задачи
        
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечная длительность курса", isSelected: false)
        return TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: DateFieldModel(), end: DateFieldModel(value: nil))
    }
    
    func getSanctionModel() -> NaturalNumberFieldModel {
        return NaturalNumberFieldModel()
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
    
    func getOnceDateModel() -> DateFieldModel {
        // TODO: - получать дату из модели задачи
        
        return DateFieldModel()
    }
    
}
