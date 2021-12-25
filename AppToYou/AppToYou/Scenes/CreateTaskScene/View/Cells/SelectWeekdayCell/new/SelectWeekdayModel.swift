import Foundation


class SelectWeekdayModel: NSCopying, ValidatableModel {
    
    private(set) var weekdayModels: [WeekdayModel]
    var errorNotification: ((CheckboxTaskError?) -> Void)?

    init(weekdayModels: [WeekdayModel]) {
        self.weekdayModels = weekdayModels
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let model = SelectWeekdayModel(weekdayModels: weekdayModels)
        return model
    }
    
}
