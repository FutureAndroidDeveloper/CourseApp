import Foundation
import UIKit


class DefaultCreateTaskModel {
    var nameModel: TextFieldModel!
    var frequencyModel: FrequencyModel!
    
    var weekdayModel: SelectWeekdayModel?
    var selectDateModel: SelectDateModel?
    
    var periodModel: TaskPeriodModel?
    var notificationModel: NotificationAboutTaskModel!
    var sanctionModel: TaskSanctionModel!
    
    func addNameHandler(_ handler: TextFieldModel) {
        nameModel = handler
    }
    
    func addFrequency(_ frequency: ATYFrequencyTypeEnum, _ handler: @escaping (ATYFrequencyTypeEnum) -> Void) {
        frequencyModel = FrequencyModel(frequency: frequency, frequencyPicked: handler)
    }
    
    func addWeekdayHandler(models: [WeekdayModel]) {
        weekdayModel = SelectWeekdayModel(weekdayModels: models)
    }
    
    func removeWeekdayHandler() {
        weekdayModel = nil
    }
    
    func addSelectDateHandler(date: DateFieldModel) {
        selectDateModel = SelectDateModel(date: date)
    }
    
    func removeSelectDateHandler() {
        selectDateModel = nil
    }
    
    func addPeriodHandler(start: DateFieldModel, end: DateFieldModel) {
        periodModel = TaskPeriodModel(start: start, end: end)
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
        sanctionModel = TaskSanctionModel(model: NaturalNumberFieldModel())
    }
    
    func prepare() -> [AnyObject] {
        var result: [AnyObject] = [nameModel]
        // TODO: - сделать функцию, которая решает между `selectDateModel, weekdayModel, periodModel`
        let tail: [AnyObject?] = [
            frequencyModel, selectDateModel, weekdayModel,
            periodModel, notificationModel, sanctionModel
        ]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result
    }
    
    func getAdditionalModels() -> [AnyObject] {
        return []
    }
}
