import Foundation


class RepeatCounterModel: ValidatableModel {
    let valueModel: NaturalNumberFieldModel
    var errorNotification: ((RitualTaskError?) -> Void)?
    
    init(valueModel: NaturalNumberFieldModel) {
        self.valueModel = valueModel
    }
    
}
