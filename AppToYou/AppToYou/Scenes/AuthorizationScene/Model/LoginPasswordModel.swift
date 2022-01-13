import Foundation


class LoginPasswordModel: ValidatableModel {
    let fieldModel: TextFieldModel
    var errorNotification: ((LoginStsatus?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
