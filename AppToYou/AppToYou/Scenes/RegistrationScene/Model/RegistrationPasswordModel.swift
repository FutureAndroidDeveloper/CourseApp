import Foundation


class RegistrationPasswordModel: ValidatableModel {
    let fieldModel: TextFieldModel
    var errorNotification: ((RegistrationError?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
