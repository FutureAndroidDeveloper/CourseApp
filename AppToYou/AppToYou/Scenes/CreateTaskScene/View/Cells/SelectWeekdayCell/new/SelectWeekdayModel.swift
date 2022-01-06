import Foundation


class SelectWeekdayModel: NSCopying, ValidatableModel {
    
    private(set) var weekdayModels: [WeekdayModel]
    private(set) var isActive: Bool = true
    var errorNotification: ((CheckboxTaskError?) -> Void)?

    init(weekdayModels: [WeekdayModel]) {
        self.weekdayModels = weekdayModels
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let model = SelectWeekdayModel(weekdayModels: weekdayModels)
        return model
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
}
