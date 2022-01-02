import Foundation
import XCoordinator


class EditUserTaskViewModel: CreateUserTaskViewModel {
    
    var updateUserTaskRequest: UserTaskUpdateRequest?
    let userTask: UserTaskResponse
    
    init(userTask: UserTaskResponse, constructor: CheckboxTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.userTask = userTask
        super.init(type: userTask.taskType, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
//    override func saveDidTapped() {
//        guard validate(model: constructor.checkboxModel) else {
//            return
//        }
//        prepare(model: constructor.checkboxModel)
//        save()
//    }
    
    override func save() {
        guard let updateTask = updateUserTaskRequest else {
            return
        }
        
        taskService.update(task: updateTask) { result in
            switch result {
            case .success(let updatedTask):
                print(updatedTask)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(model: DefaultCreateTaskModel) {
        let id = userTask.identifier.id
        let type = userTask.taskType
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = model.sanctionModel.fieldModel.value
        let isInfinite = model.periodModel?.isInfiniteModel.isSelected ?? false
        
        guard let start = model.periodModel?.start.value ?? model.selectDateModel?.date.value else {
            return
        }
        
        updateUserTaskRequest = UserTaskUpdateRequest(
            id: id, taskType: type, taskName: name, frequencyType: freq, taskSanction: sanction, infiniteExecution: isInfinite,
            startDate: start.toString(dateFormat: .localeYearDate)
        )
        let endDate = freq == .ONCE ? start : model.periodModel?.end.value

        updateUserTaskRequest?.endDate = endDate?.toString(dateFormat: .localeYearDate)
        updateUserTaskRequest?.daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? Self.activeDayCode : Self.inactiveDayCode }
            .joined()

        if model.notificationModel.isEnabled {
            let separator = Self.timeSeparator
            updateUserTaskRequest?.reminderList = model.notificationModel.notificationModels
                .map { "\($0.hourModel.value)\(separator)\($0.minModel.value)" }
        } else {
            updateUserTaskRequest?.reminderList = []
        }
    }
    
    override func getNameModel() -> TextFieldModel {
        let nameField = super.getNameModel()
        nameField.update(value: userTask.taskName)
        return nameField
    }
    
    override func getFrequncy() -> FrequncyValueModel {
        let frequencyField = super.getFrequncy()
        frequencyField.update(userTask.frequencyType)
        return frequencyField
    }
    
    override func getPeriodModel() -> TaskPeriodModel {
        let model = super.getPeriodModel()
        let startDate = userTask.startDate.toDate(dateFormat: .simpleDateFormatFullYear)
        let endDate = userTask.endDate?.toDate(dateFormat: .simpleDateFormatFullYear)
        
        model.isInfiniteModel.chandeSelectedState(userTask.infiniteExecution)
        model.start.update(value: startDate)
        model.end.update(value: endDate)
        return model
    }
    
    override func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool) {
        let notifications = userTask.reminderList ?? []
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
        field.update(value: userTask.taskSanction)
        
        return (field, min, userTask.taskSanction > .zero)
    }
    
    override func getWeekdayModels() -> [WeekdayModel] {
        let models = super.getWeekdayModels()
        
        if let daysCode = userTask.daysCode {
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
        
        if userTask.frequencyType == .ONCE {
            let date = userTask.startDate.toDate(dateFormat: .simpleDateFormatFullYear)
            model.update(value: date)
        }
        return model
    }
    
}
