import Foundation


class FieldModel<Value> {
    private(set) var value: Value
    let placeholder: String?
    
    init(value: Value, placeholder: String? = nil) {
        self.value = value
        self.placeholder = placeholder
    }
    
    func update(value: Value) {
        self.value = value
    }
}
