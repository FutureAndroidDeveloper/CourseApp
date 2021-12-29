import Foundation


class RepeatCounterModel: ValidatableModel {
    let valueModel: NaturalNumberFieldModel
    let lockModel: LockButtonModel?
    var errorNotification: ((RitualTaskError?) -> Void)?
    
    init(valueModel: NaturalNumberFieldModel, lockModel: LockButtonModel?) {
        self.valueModel = valueModel
        self.lockModel = lockModel
    }
    
}
