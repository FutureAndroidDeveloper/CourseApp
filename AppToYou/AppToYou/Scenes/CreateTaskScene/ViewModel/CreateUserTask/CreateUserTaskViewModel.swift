import Foundation
import XCoordinator


class CreateUserTaskViewModel: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput, CheckboxTaskDataSource, CreatorDelegate {
    static let timeSeparator: Character = ":"
    static let activeDayCode: String = "1"
    static let inactiveDayCode: String = "0"
    
    private let constructor: CheckboxTaskConstructor
    private let validator = CheckboxTaskValidator()
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    let type: TaskType
    let mode: CreateTaskMode
    let taskRouter: UnownedRouter<TaskRoute>
    let synchronizationService: SynchronizationService
    
    var task: Task
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    var title: Observable<String?> = Observable(String())
    

    init(type: TaskType, constructor: CheckboxTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.type = type
        self.mode = mode
        self.synchronizationService = synchronizationService
        self.taskRouter = taskRouter
        self.constructor = constructor
        
        task = Task()
        title.value = "Создание новой задачи"
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
        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        let frequency = model.frequencyModel.value.frequency
        let endDate = frequency == .ONCE ? start : model.periodModel?.end.value
        
        task.taskType = type
        task.frequencyType = frequency
        task.taskName = model.nameModel.fieldModel.value
        task.taskSanction = model.sanctionModel.fieldModel.value
        task.infiniteExecution = model.periodModel?.isInfiniteModel.isSelected ?? false
        task.startDate = start.toString(dateFormat: .localeYearDate)
        task.endDate = endDate?.toString(dateFormat: .localeYearDate)
        task.daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? Self.activeDayCode : Self.inactiveDayCode }
            .joined()
        
        task.reminderList.removeAll()
        
        if model.notificationModel.isEnabled {
            model.notificationModel.notificationModels
                .map { "\($0.hourModel.value)\(Self.timeSeparator)\($0.minModel.value)" }
                .forEach { task.reminderList.append($0) }
        }
    }
    
    func save() {
        synchronizationService.create(task: task)
        taskRouter.trigger(.taskDidCreate)
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
        let start = DateFieldModel()
        let end = DateFieldModel(value: nil)
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
