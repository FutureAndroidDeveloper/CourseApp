import Foundation


class DescriptionModel: ValidatableModel {
    let fieldModel: PlaceholderTextViewModel
    var errorNotification: ((CommonValidationError.Description?) -> Void)?
    
    init(fieldModel: PlaceholderTextViewModel) {
        self.fieldModel = fieldModel
    }
}
