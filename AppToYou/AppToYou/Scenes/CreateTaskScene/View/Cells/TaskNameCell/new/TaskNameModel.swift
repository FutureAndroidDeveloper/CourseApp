import Foundation


class TaskNameModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((CheckboxTaskError?) -> Void)?
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
