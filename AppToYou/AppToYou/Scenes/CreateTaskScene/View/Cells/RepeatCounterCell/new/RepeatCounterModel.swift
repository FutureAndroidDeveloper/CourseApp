import Foundation


class RepeatCounterModel: ValidatableModel {
    let valueModel: NaturalNumberFieldModel
    let lockModel: LockButtonModel?
    
    private(set) var style: FieldStyle = StyleManager.standartTextField
    private(set) var isActive: Bool = true
    var errorNotification: ((RitualTaskError?) -> Void)?
    
    init(valueModel: NaturalNumberFieldModel, lockModel: LockButtonModel?) {
        self.valueModel = valueModel
        self.lockModel = lockModel
    }
    
    func updateActiveState(_ isActive: Bool) {
        self.isActive = isActive
    }
    
    func updateStyle(_ style: FieldStyle) {
        self.style = style
    }
}
