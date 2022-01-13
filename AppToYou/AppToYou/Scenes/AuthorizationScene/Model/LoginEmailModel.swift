import Foundation


class LoginEmailModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((LoginStsatus?) -> Void)?
    
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
