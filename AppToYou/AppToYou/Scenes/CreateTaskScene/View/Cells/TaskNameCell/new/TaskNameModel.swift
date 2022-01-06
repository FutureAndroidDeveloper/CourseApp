import Foundation


class TaskNameModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    private(set) var isActive: Bool = true
    var errorNotification: ((CommonValidationError.Name?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
}
