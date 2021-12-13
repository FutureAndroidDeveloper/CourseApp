import UIKit


class TextField: PaddingTextField {
    
    private var model = TextFieldModel()
    
    func configure(with model: TextFieldModel) {
        self.model = model
        placeholder = model.placeholder
        text = model.value
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }
        
        let newText = text.replacingCharacters(in: range, with: string)
        model.update(value: newText)
        return true
    }
    
}


