import Foundation


class TextFieldModel: BaseFieldModel<String> {
    
    private struct Constants {
        static let defaultValue = String()
    }
    
    convenience init() {
        self.init(value: Constants.defaultValue)
    }
    
}
