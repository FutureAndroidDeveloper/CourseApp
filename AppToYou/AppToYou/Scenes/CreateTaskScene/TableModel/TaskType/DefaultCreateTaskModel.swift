import Foundation
import UIKit


class DefaultCreateTaskModel {
    var nameModel: TaskNameModel!
    var frequencyModel: FrequencyModel!
    var notificationModel: NotificationAboutTaskModel!
    var sanctionModel: TaskSanctionModel!
    
    private var prevWeekdaysModel: SelectWeekdayModel?
    var weekdayModel: SelectWeekdayModel?
    
    private var prevDateModel: SelectDateModel?
    var selectDateModel: SelectDateModel?
    
    private var prevPeriodModel: TaskPeriodModel?
    var periodModel: TaskPeriodModel?
    
    // Name
    func addName(model: TextFieldModel) {
        nameModel = TaskNameModel(fieldModel: model)
    }
    
    // Freq
    func addFrequency(_ value: FrequncyValueModel, mode: CreateTaskMode, _ handler: @escaping (Frequency) -> Void) {
        frequencyModel = FrequencyModel(value: value, taskMode: mode, frequencyPicked: handler)
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
                                isEnabled: Bool,
                                timerCallback: @escaping (TaskNoticationDelegate) -> Void) {
        
        notificationModel = NotificationAboutTaskModel(notificationModels: notificationModels,
                                                       isEnabled: isEnabled,
                                                       timerCallback: timerCallback)
    }
    
    // Sanction
    func addSanction(model: NaturalNumberFieldModel, isEnabled: Bool, minValue: Int,
                     switchChanged: @escaping (Bool) -> Void, questionCallback: @escaping () -> Void) {
        
        sanctionModel = TaskSanctionModel(fieldModel: model, isEnabled: isEnabled, minValue: minValue,
                                          switchChanged: switchChanged, questionCallback: questionCallback)
    }
    
    func prepare() -> [AnyObject] {
        var result: [AnyObject?] = [nameModel]
        
        let tail: [AnyObject?] = [
            frequencyModel, selectDateModel, weekdayModel,
            periodModel, notificationModel, sanctionModel,
        ]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result.compactMap { $0 }
    }
    
    func getAdditionalModels() -> [AnyObject] {
        return []
    }
}
