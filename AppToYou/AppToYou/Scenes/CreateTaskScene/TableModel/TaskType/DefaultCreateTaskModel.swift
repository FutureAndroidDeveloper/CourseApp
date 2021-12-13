import Foundation


class DefaultCreateTaskModel {
    var nameModel: TaskNameModel!
    var frequencyModel: CreateTaskCountingCellModel!
    
    var weekdayModel: SelectWeekdayModel?
    var selectDateModel: SelectDateModel?
    
    var periodModel: TaskPeriodModel?
    var notificationModel: NotificationAboutTaskModel!
    var sanctionModel: CreateSanctionTaskCellModel!
    var saveModel: SaveTaskCellModel!
    
    func addNameHandler(_ handler: TextFieldModel) {
        nameModel = TaskNameModel(fieldModel: handler)
    }
    
    func addFrequencyHandler(_ handler: @escaping (ATYFrequencyTypeEnum) -> Void) {
        frequencyModel = CreateTaskCountingCellModel(frequencyPicked: handler)
    }
    
    func addWeekdayHandler(models: [WeekdayModel]) {
        weekdayModel = SelectWeekdayModel(weekdayModels: models)
    }
    
    func removeWeekdayHandler() {
        weekdayModel = nil
    }
    
    func addSelectDateHandler() {
        selectDateModel = SelectDateModel()
    }
    
    func removeSelectDateHandler() {
        selectDateModel = nil
    }
    
    func addPeriodHandler(startPicked: @escaping DateCompletion, endPicked: @escaping DateCompletion) {
        periodModel = TaskPeriodModel(startPicked: startPicked, endPicked: endPicked)
    }
    
    func removePeriodHandler() {
        periodModel = nil
    }
    
    func addNotificationHandler(notificationModels: [NotificationTaskTimeModel],
                                switchCallback: @escaping (Bool) -> Void,
                                timerCallback: @escaping (TaskNoticationDelegate) -> Void) {
        
        notificationModel = NotificationAboutTaskModel(notificationModels: notificationModels,
                                                       switchCallback: switchCallback,
                                                       timerCallback: timerCallback)
    }
    
    func addSanctionHandler(callbackText: @escaping (String) -> Void, questionCallback: @escaping () -> Void) {
        sanctionModel = CreateSanctionTaskCellModel(callbackText: callbackText, questionCallback: questionCallback)
    }
    
    func addSaveHandler(_ handler: @escaping () -> Void) {
        saveModel = SaveTaskCellModel(callback: handler)
    }
    
    func prepare() -> [AnyObject] {
        var result: [AnyObject] = [nameModel]
        // TODO: - сделать функцию, которая решает между `selectDateModel, weekdayModel, periodModel`
        let tail: [AnyObject?] = [frequencyModel, selectDateModel, weekdayModel, periodModel, notificationModel, sanctionModel, saveModel]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result
    }
    
    func getAdditionalModels() -> [AnyObject] {
        return []
    }
}
