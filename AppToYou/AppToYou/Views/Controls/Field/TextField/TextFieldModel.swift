import Foundation


class TextFieldModel: FieldModel<String> {
    
    private struct Constants {
        static let defaultValue = String()
    }
    
    convenience init() {
        self.init(value: Constants.defaultValue)
    }
}
