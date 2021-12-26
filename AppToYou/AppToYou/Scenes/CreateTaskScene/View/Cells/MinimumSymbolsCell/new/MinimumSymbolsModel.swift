import Foundation


class MinimumSymbolsModel: ValidatableModel {
    
    let fieldModel: NaturalNumberFieldModel
    var errorNotification: ((TextTaskError?) -> Void)?
    
    init(fieldModel: NaturalNumberFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
