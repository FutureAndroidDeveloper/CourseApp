import UIKit


/**
 Поле с текстовым представлением.
 */
class TextField: BaseField<String>, UITextFieldDelegate {
    
    override func configure(with model: FieldModel<String>) {
        super.configure(with: model)
        delegate = self
    }
    
    override func setContentModel(_ model: BaseFieldModel<String>) {
        super.setContentModel(model)
        text = model.value
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return false
        }
        
        let newText = text.replacingCharacters(in: range, with: string)
        model?.content.fieldModel.update(value: newText)
        return true
    }
    
}

