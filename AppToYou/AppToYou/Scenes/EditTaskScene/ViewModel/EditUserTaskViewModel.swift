import Foundation
import XCoordinator


class EditUserTaskViewModel: CreateUserTaskViewModel {
    let updatedTask: Task
    
    init(task: Task, constructor: CheckboxTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        updatedTask = Task(value: task)
        super.init(type: task.taskType, constructor: constructor, mode: mode, synchronizationService: synchronizationService, taskRouter: taskRouter)
        self.task = task
        
        title.value = "Редактирование задачи"
    }
    
    override func update() {
        super.update()
        getConstructor().setEnableStateForFields()
    }
    
    override func save() {
        synchronizationService.update(task: updatedTask)
        taskRouter.trigger(.done)
    }
    
    override func prepare(model: DefaultCreateTaskModel) {
        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        let frequency = model.frequencyModel.value.frequency
        let endDate = frequency == .ONCE ? start : model.periodModel?.end.value
        
        updatedTask.taskName = model.nameModel.fieldModel.value
        updatedTask.frequencyType = frequency
        updatedTask.infiniteExecution = model.periodModel?.isInfiniteModel.isSelected ?? false
        updatedTask.taskSanction = model.sanctionModel.fieldModel.value
        updatedTask.startDate = start.toString(dateFormat: .localeYearDate)
        updatedTask.endDate = endDate?.toString(dateFormat: .localeYearDate)
        updatedTask.daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? Self.activeDayCode : Self.inactiveDayCode }
            .joined()
        
        updatedTask.reminderList.removeAll()
        
        if model.notificationModel.isEnabled {
            model.notificationModel.notificationModels
                .map { "\($0.hourModel.value)\(Self.timeSeparator)\($0.minModel.value)" }
                .forEach { updatedTask.reminderList.append($0) }
        }
    }
    
    override func getNameModel() -> TextFieldModel {
        let nameField = super.getNameModel()
        nameField.update(value: task.taskName)
        return nameField
    }
    
    override func getFrequncy() -> FrequncyValueModel {
        let frequencyField = super.getFrequncy()
        frequencyField.update(task.frequencyType)
        return frequencyField
    }
    
    override func getPeriodModel() -> TaskPeriodModel {
        let model = super.getPeriodModel()
        let startDate = task.startDate.toDate(dateFormat: .localeYearDate)
        let endDate = task.endDate?.toDate(dateFormat: .localeYearDate)
        
        model.isInfiniteModel.chandeSelectedState(task.infiniteExecution)
        model.start.update(value: startDate)
        model.end.update(value: endDate)
        return model
    }
    
    override func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool) {
        let notifications = Array(task.reminderList)
        var isEnabled = true
        
        var notificationModels = notifications
            .map { $0.split(separator: Self.timeSeparator) }
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
    
    override func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let (field, min, _) = super.getSanctionModel()
        field.update(value: task.taskSanction)
        
        return (field, min, task.taskSanction > .zero)
    }
    
    override func getWeekdayModels() -> [WeekdayModel] {
        let models = super.getWeekdayModels()
        
        if let daysCode = task.daysCode {
            let codeArray = Array(daysCode)
            zip(models, codeArray).forEach { item in
                let isSelected = String(item.1) == Self.activeDayCode
                item.0.chandeSelectedState(isSelected)
            }
        }
        return models
    }
    
    override func getOnceDateModel() -> DateFieldModel {
        let model = super.getOnceDateModel()
        
        if task.frequencyType == .ONCE {
            let date = task.startDate.toDate(dateFormat: .localeYearDate)
            model.update(value: date)
        }
        return model
    }
    
}
