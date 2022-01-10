import Foundation
import XCoordinator



class CreateUserTaskViewModel: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput, CheckboxTaskDataSource, CreatorDelegate {
    static let timeSeparator: Character = ":"
    static let activeDayCode: String = "1"
    static let inactiveDayCode: String = "0"

    
    private let constructor: CheckboxTaskConstructor
    private let validator = CheckboxTaskValidator()
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    let type: ATYTaskType
    let mode: CreateTaskMode
    let taskRouter: UnownedRouter<TaskRoute>
    let taskService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    var userTaskRequest: UserTaskCreateRequest?
    
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    

    init(type: ATYTaskType, constructor: CheckboxTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.type = type
        self.mode = mode
        self.taskRouter = taskRouter
        self.constructor = constructor
    }
    
    func getConstructor() -> CheckboxTaskConstructor {
        return constructor
    }
    
    func getValidator() -> CheckboxTaskValidator<DefaultCreateTaskModel> {
        return validator
    }
    
    func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    func saveDidTapped() {
        guard validate(model: constructor.checkboxModel) else {
            return
        }
        prepare(model: constructor.checkboxModel)
        save()
    }
    
    func validate(model: DefaultCreateTaskModel) -> Bool {
        validator.validate(model: model)
        return !validator.hasError
    }
    
    func prepare(model: DefaultCreateTaskModel) {
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = model.sanctionModel.fieldModel.value
        let isInfinite = model.periodModel?.isInfiniteModel.isSelected ?? false

        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        
        userTaskRequest = UserTaskCreateRequest(
            taskName: name, taskType: type, frequencyType: freq, taskSanction: sanction,
            infiniteExecution: isInfinite, startDate: start.toString(dateFormat: .localeYearDate)
        )
        let endDate = freq == .ONCE ? start : model.periodModel?.end.value
        
        userTaskRequest?.endDate = endDate?.toString(dateFormat: .localeYearDate)
        userTaskRequest?.daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? Self.activeDayCode : Self.inactiveDayCode }
            .joined()
        
        if model.notificationModel.isEnabled {
            let separator = Self.timeSeparator
            userTaskRequest?.reminderList = model.notificationModel.notificationModels
                .map { "\($0.hourModel.value)\(separator)\($0.minModel.value)" }
        }
    }
    
    func save() {
        guard let userTask = userTaskRequest else {
            return
        }
        
        taskService.create(task: userTask) { [weak self] result in
            switch result {
            case .success(let newTask):
                print(newTask)
                self?.taskRouter.trigger(.done)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?) {
        notificationDelegate = delegate
        taskRouter.trigger(.timePicker(type: pickerType))
    }
    
    func showSanctionQuestion() {
        taskRouter.trigger(.sanctionQuestion)
    }
    
    func courseTaskDurationPicked(_ duration: Duration) {
        return
    }
    
    func userTaskdurationPicked(_ duration: DurationTime) {
        return
    }
    
    func notificationPicked(_ notification: NotificationTime) {
        guard let notificationDelegate = notificationDelegate else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: notification)
        notificationDelegate.notificationDidAdd(model)
        updateState()
    }
    
    func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func updateState() {
        updatedState.value = ()
    }

    func getNameModel() -> TextFieldModel {
        let model = TextFieldModel(value: String(), placeholder:  R.string.localizable.forExampleDoExercises())
        return model
    }
    
    func getFrequncy() -> FrequncyValueModel {
        return FrequncyValueModel(frequency: .EVERYDAY)
    }
    
    func getPeriodModel() -> TaskPeriodModel {
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечная длительность задачи", isSelected: true)
        let start = DateFieldModel(value: Date())
        let end = DateFieldModel()
        let model = TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: start, end: end)
                                   
        return model
    }
    
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool) {
        let hourModel = TimeBlockModelFactory.getHourModel()
        let minModel = TimeBlockModelFactory.getMinModel()
        let defaultModel = NotificationTaskTimeModel(hourModel: hourModel, minModel: minModel)
        
        return ([defaultModel], false)
    }
    
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let model = NaturalNumberFieldModel()
        return (model, .zero, false)
    }
    
    func getWeekdayModels() -> [WeekdayModel] {
        // получение названий дней недели
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        let models = orderedSymbols.map { WeekdayModel(title: $0) }
        return models
    }
    
    func getOnceDateModel() -> DateFieldModel {
        return DateFieldModel(value: Date())
    }
    
}
