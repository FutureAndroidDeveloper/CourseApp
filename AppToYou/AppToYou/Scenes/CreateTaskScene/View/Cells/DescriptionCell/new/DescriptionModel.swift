import Foundation


class DescriptionModel: ValidatableModel {
    let fieldModel: PlaceholderTextViewModel
    var errorNotification: ((TextTaskError?) -> Void)?
    
    init(fieldModel: PlaceholderTextViewModel) {
        self.fieldModel = fieldModel
    }
}
