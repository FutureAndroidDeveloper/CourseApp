import Foundation


class RegistrationNameModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((RegistrationError?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
