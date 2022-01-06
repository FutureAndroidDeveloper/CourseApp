import Foundation


class TaskPeriodModel: NSCopying, ValidatableModel {
    
    let isInfiniteModel: TitledCheckBoxModel
    let start: DateFieldModel
    let end: DateFieldModel
    
    private(set) var isActive: Bool = true
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    
    init(isInfiniteModel: TitledCheckBoxModel, start: DateFieldModel, end: DateFieldModel) {
        self.isInfiniteModel = isInfiniteModel
        self.start = start
        self.end = end
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: start, end: end)
        return model
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
}
