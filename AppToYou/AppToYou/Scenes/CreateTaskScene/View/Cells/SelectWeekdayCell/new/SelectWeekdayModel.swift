import Foundation


class SelectWeekdayModel: NSCopying {
    var weekdayModels: [WeekdayModel]

    init(weekdayModels: [WeekdayModel]) {
        self.weekdayModels = weekdayModels
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let model = SelectWeekdayModel(weekdayModels: weekdayModels)
        return model
    }
    
}
