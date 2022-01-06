import Foundation


class MinimumSymbolsModel: ValidatableModel {
    let fieldModel: NaturalNumberFieldModel
    let lockModel: LockButtonModel?
    
    private(set) var isActive: Bool = true
    var errorNotification: ((TextTaskError?) -> Void)?
    
    init(fieldModel: NaturalNumberFieldModel, lockModel: LockButtonModel?) {
        self.fieldModel = fieldModel
        self.lockModel = lockModel
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
}
