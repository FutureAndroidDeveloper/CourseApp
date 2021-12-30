import Foundation


class DescriptionModel: ValidatableModel {
    let fieldModel: PlaceholderTextViewModel
    var isEditable: Bool = true
    var errorNotification: ((CommonValidationError.Description?) -> Void)?
    
    init(fieldModel: PlaceholderTextViewModel) {
        self.fieldModel = fieldModel
    }
}
