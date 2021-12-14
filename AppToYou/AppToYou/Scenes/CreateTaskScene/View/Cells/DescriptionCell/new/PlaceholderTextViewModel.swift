import Foundation


class PlaceholderTextViewModel {
    private(set) var text: String?
    let placeholder: String
    
    init(text: String?, placeholder: String) {
        self.text = text
        self.placeholder = placeholder
    }
    
    func update(text: String) {
        self.text = text
    }
    
}
