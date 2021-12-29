import Foundation


class CourseTaskMinSanctionModel: ValidatableModel {
    let fieldModel: NaturalNumberFieldModel
    private(set) var isActive: Bool
    
    var didActivate: ((Bool) -> Void)?
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    
    init(fieldModel: NaturalNumberFieldModel) {
        self.fieldModel = fieldModel
        self.isActive = false
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
}
