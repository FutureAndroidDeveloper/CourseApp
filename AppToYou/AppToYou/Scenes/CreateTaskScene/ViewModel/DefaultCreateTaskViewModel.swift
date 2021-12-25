import Foundation
import XCoordinator


class DefaultCreateTaskViewModel: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {

    private lazy var constructor: DefaultTaskModel = {
        return DefaultTaskModel(delegate: self)
    }()

    private let type: ATYTaskType
    private let router: UnownedRouter<TasksRoute>
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    private let taskService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    private let validator = CheckboxTaskValidator()
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
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
            return
        }
        
        taskService.create(task: task) { result in
            switch result {
            case .success(let newTask):
                print(newTask)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func saveDidTapped() {
        validator.validate(model: constructor.model)
        
        if !validator.hasError {
            makeModel()
            saveModel()
        }
    }
    
    func makeModel() {
        print(#function)
        let model = constructor.model
        
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = Int32(model.sanctionModel.fieldModel.value)
        let isInfinite = model.periodModel?.isInfiniteModel.isSelected ?? false

        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        taskRequest = UserTaskCreateRequest(
            taskName: name, taskType: type, frequencyType: freq,
            taskSanction: sanction, infiniteExecution: isInfinite, startDate: start.toString(dateFormat: .localeYearDate)
        )
        
        taskRequest?.endDate = model.periodModel?.end.value?.toString(dateFormat: .localeYearDate)
        taskRequest?.daysCode = model.weekdayModel?.weekdayModels
            .compactMap { $0 }
            .map { $0.isSelected ? "1" : "0" }
            .joined()
        
        if model.notificationModel.isEnabled {
            taskRequest?.reminderList = model.notificationModel.notificationModels
                .map { "\($0.hourModel.value):\($0.minModel.value)" }
        }
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
    
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool) {
        // TODO: - получать нотификации из модели задачи
        
        let model = NotificationTaskTimeModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                              minModel: TimeBlockModelFactory.getMinModel())
        return ([model], false)
    }
    
    func getSanctionModel() -> (model: NaturalNumberFieldModel, isEnabled: Bool) {
        // TODO: - получать штраф из модели
        return (NaturalNumberFieldModel(), false)
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
