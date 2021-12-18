import Foundation
import UIKit


class DefaultCreateTaskModel {
    var nameModel: TaskNameModel!
    var frequencyModel: FrequencyModel!
    
    private var prevWeekdaysModel: SelectWeekdayModel?
    var weekdayModel: SelectWeekdayModel?
    
    private var prevDateModel: SelectDateModel?
    var selectDateModel: SelectDateModel?
    
    private var prevPeriodModel: TaskPeriodModel?
    var periodModel: TaskPeriodModel?
    
    
    var notificationModel: NotificationAboutTaskModel!
    var sanctionModel: TaskSanctionModel!
    
    // Name
    func addNameHandler(_ handler: TextFieldModel) {
        nameModel = TaskNameModel(fieldModel: handler)
    }
    
    // Freq
    func addFrequency(_ frequency: ATYFrequencyTypeEnum, _ handler: @escaping (ATYFrequencyTypeEnum) -> Void) {
        frequencyModel = FrequencyModel(frequency: frequency, frequencyPicked: handler)
    }
    
    // Days
    func addWeekdayHandler(models: [WeekdayModel]) {
        weekdayModel = prevWeekdaysModel ?? SelectWeekdayModel(weekdayModels: models)
    }
    
    func removeWeekdayHandler() {
        guard let model = weekdayModel else {
            return
        }
        
        prevWeekdaysModel = model.copy() as? SelectWeekdayModel
        weekdayModel = nil
        
    }
    
    // Once day
    func addSelectDateHandler(date: DateFieldModel) {
        selectDateModel = prevDateModel ?? SelectDateModel(date: date)
    }
    
    
    func removeSelectDateHandler() {
        guard let model = selectDateModel else {
            return
        }
        
        prevDateModel = model.copy() as? SelectDateModel
        selectDateModel = nil
    }
    
    // Period
    func addPeriodHandler(isInfiniteModel: TitledCheckBoxModel, start: DateFieldModel, end: DateFieldModel) {
        periodModel = prevPeriodModel ?? TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: start, end: end)
    }
    
    func removePeriodHandler() {
        guard let model = periodModel else {
            return
        }
        
        prevPeriodModel = model.copy() as? TaskPeriodModel
        periodModel = nil
    }
    
    // Notification
    func addNotificationHandler(notificationModels: [NotificationTaskTimeModel],
                                switchCallback: @escaping (Bool) -> Void,
                                timerCallback: @escaping (TaskNoticationDelegate) -> Void) {
        
        notificationModel = NotificationAboutTaskModel(notificationModels: notificationModels,
                                                       switchCallback: switchCallback,
                                                       timerCallback: timerCallback)
    }
    
    // Sanction
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
