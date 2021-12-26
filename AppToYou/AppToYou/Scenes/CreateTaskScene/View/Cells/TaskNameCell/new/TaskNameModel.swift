import Foundation


class TaskNameModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((CommonValidationError.Name?) -> Void)?
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
