import Foundation


class RegistrationEmailModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((RegistrationError?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
