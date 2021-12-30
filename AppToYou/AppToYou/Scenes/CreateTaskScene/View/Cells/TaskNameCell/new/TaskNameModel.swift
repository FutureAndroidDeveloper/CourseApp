import Foundation


class TaskNameModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((CommonValidationError.Name?) -> Void)?
    
    var isEditable: Bool = true
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
