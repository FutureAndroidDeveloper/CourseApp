import Foundation
import XCoordinator


class DefaultCreateTaskViewModel<Model: DefaultCreateTaskModel>: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {
    
    private let notificationSeparator: Character = ":"
    private let activeDayCode: String = "1"
    private let inactiveDayCode: String = "0"

    private lazy var constructor: DefaultTaskModel = {
        return DefaultTaskModel(mode: mode, delegate: self)
    }()

    private let type: ATYTaskType
    private let router: UnownedRouter<TasksRoute>
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    private let taskService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    private let validator = CheckboxTaskValidator()
    
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    let task: UserTaskResponse?
    
    // для создания запроса
    var taskRequest: UserTaskCreateRequest?
    
    let mode: CreateTaskMode


    init(type: ATYTaskType, task: UserTaskResponse?, mode: CreateTaskMode, router: UnownedRouter<TasksRoute>) {
        self.type = type
        self.task = task
        self.mode = mode
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
    
    func userTaskdurationPicked(_ duration: DurationTime) {
        //
    }
    
    func courseTaskDurationPicked(_ duration: Duration) {
        let time = DurationTime(hour: "\(duration.year)", min: "\(duration.month)", sec: "\(duration.day)")
        constructor.model.courseTaskDurationModel?.durationModel.update(durationTime: time)
        update()
    }

    func saveDidTapped() {
        guard
            let checkboxModel = constructor.model as? Model,
            validate(model: checkboxModel)
        else {
            return
        }
        save()
    }
    
    func validate(model: Model) -> Bool {
        validator.validate(model: model)
        if !validator.hasError {
            prepare(model: model)
        }
        return !validator.hasError
    }
    
    func prepare(model: Model) {
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = model.sanctionModel.fieldModel.value
        let isInfinite = model.periodModel?.isInfiniteModel.isSelected ?? false

        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        taskRequest = UserTaskCreateRequest(
            taskName: name, taskType: type, frequencyType: freq,
            taskSanction: sanction, infiniteExecution: isInfinite,
            startDate: start.toString(dateFormat: .localeYearDate)
        )
        
        let endDate = freq == .ONCE ? start : model.periodModel?.end.value
        
        taskRequest?.endDate = endDate?.toString(dateFormat: .localeYearDate)
        taskRequest?.daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? activeDayCode : inactiveDayCode }
            .joined()
        
        if model.notificationModel.isEnabled {
            let separator = notificationSeparator
            taskRequest?.reminderList = model.notificationModel.notificationModels
                .map { "\($0.hourModel.value)\(separator)\($0.minModel.value)" }
        }
    }
    
    func save() {
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
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
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
        let name = task?.taskName ?? String()
        let model = TextFieldModel(value: name, placeholder:  R.string.localizable.forExampleDoExercises())
        
        return model
    }
    
    func getFrequncy() -> FrequncyValueModel {
        let frequency = task?.frequencyType ?? .EVERYDAY
        return FrequncyValueModel(frequency: frequency)
    }
    
    func getPeriodModel() -> TaskPeriodModel {
        let isInfinite = task?.infiniteExecution ?? true
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечная длительность курса", isSelected: isInfinite)
        
        let start = task?.startDate.toDate(dateFormat: .simpleDateFormatFullYear) ?? Date()
        let end = task?.endDate?.toDate(dateFormat: .simpleDateFormatFullYear)
        
        let model = TaskPeriodModel(
            isInfiniteModel: isInfiniteModel,
            start: DateFieldModel(value: start),
            end: DateFieldModel(value: end)
        )
        return model
    }
    
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool) {
        let notifications = task?.reminderList ?? []
        var isEnabled = true
        
        var notificationModels = notifications
            .map { $0.split(separator: notificationSeparator) }
            .map { notification -> NotificationTaskTimeModel in
                let hourModel = TimeBlockModelFactory.getHourModel()
                let minModel = TimeBlockModelFactory.getMinModel()
                
                notification.enumerated().forEach { item in
                    let value = String(item.element)
                    switch item.offset {
                    case 0: hourModel.update(value: value)
                    case 1: minModel.update(value: value)
                    default: break
                    }
                }
                return NotificationTaskTimeModel(hourModel: hourModel, minModel: minModel)
            }
        
        if notificationModels.isEmpty {
            let emptyModel = NotificationTaskTimeModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                                       minModel: TimeBlockModelFactory.getHourModel())
            notificationModels.append(emptyModel)
            isEnabled = false
        }
        
        return (notificationModels, isEnabled)
    }
    
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let minValue = task?.minimumCourseTaskSanction ?? 0
        let sanction = task?.taskSanction ?? minValue
        let model = NaturalNumberFieldModel(value: sanction)
        
        return (model, minValue, sanction > .zero)
    }
    
    func getWeekdayModels() -> [WeekdayModel] {
        // получение названий дней недели
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        let defaultDaysCode = orderedSymbols
            .map { _ in "0" }
            .joined()
        
        let daysCode = task?.daysCode ?? defaultDaysCode
        let codeArray = Array(daysCode)
        
        let models = zip(orderedSymbols, codeArray).map { item in
            return WeekdayModel(title: item.0, isSelected: String(item.1) == activeDayCode)
        }
        return models
    }
    
    func getOnceDateModel() -> DateFieldModel {
        let frequency = task?.frequencyType
        let start = task?.startDate.toDate(dateFormat: .simpleDateFormatFullYear)
        
        if let freq = frequency, freq == .ONCE {
            return DateFieldModel(value: start)
        } else {
            return DateFieldModel()
        }
    }
    
    func getMinCourseSanctionModel() -> NaturalNumberFieldModel {
        let minSanction = task?.minimumCourseTaskSanction ?? 0
        return NaturalNumberFieldModel(value: minSanction)
    }
    
    func getCourseTaskDurationModel() -> (duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel) {
        // В другом типе зад должно быть поле .duration
        let hour = TimeBlockModelFactory.getHourModel()
        let min = TimeBlockModelFactory.getMinModel()
        let sec = TimeBlockModelFactory.getSecModel()
        let duration = TaskDurationModel(hourModel: hour, minModel: min, secModel: sec)
        
        let isSelected = task?.infiniteExecution ?? true
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечное выполнение", isSelected: isSelected)
        
        return (duration, isInfiniteModel)
    }
    
    func getCourseName() -> String {
        let name = task?.courseName ?? String()
        return name
    }
    
}
