import Foundation


class MinimumSymbolsModel: ValidatableModel {
    let fieldModel: NaturalNumberFieldModel
    let lockModel: LockButtonModel?
    
    var errorNotification: ((TextTaskError?) -> Void)?
    
    init(fieldModel: NaturalNumberFieldModel, lockModel: LockButtonModel?) {
        self.fieldModel = fieldModel
        self.lockModel = lockModel
    }
    
}
