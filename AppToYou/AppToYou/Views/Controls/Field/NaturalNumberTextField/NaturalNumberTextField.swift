import UIKit


//class NaturalNumberTextField: UITextField, UITextFieldDelegate {
//
//    private struct Constsants {
//        static let valueFieldSize = CGSize(width: 182, height: 44)
//        static let valueInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
//    }
//
//    private let numberFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.allowsFloats = false
//        return formatter
//    }()
//
//    private var model: NaturalNumberFieldModel = NaturalNumberFieldModel()
//
//    override var intrinsicContentSize: CGSize {
//        return Constsants.valueFieldSize
//    }
//
//    init() {
//        super.init(frame: .zero)
//        setup()
//        configure(with: model)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = bounds.height / 2
//    }
//
//    private func setup() {
//        keyboardType = .numberPad
//        backgroundColor = R.color.backgroundTextFieldsColor()
//        textColor = R.color.titleTextColor()
//        delegate = self
//    }
//
//    func configure(with model: NaturalNumberFieldModel) {
//        self.model = model
//        placeholder = model.placeholder
//
//        if model.value != .zero {
//            text = String(model.value)
//        }
//    }
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: Constsants.valueInsets)
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: Constsants.valueInsets)
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: Constsants.valueInsets)
//    }
//
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
//            return false
//        }
//
//        let regEx = "^[1-9][0-9]*$"
//        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
//        let validationResult = predicate.evaluate(with: newText)
//
//        // удаление символов
//        if string == "", range.length != .zero, range.location == .zero {
//            update(new: String(Int.zero))
//            return true
//        }
//
//        if validationResult {
//            update(new: newText)
//        }
//
//        return validationResult
//    }
//
//
//    private func update(new string: String) {
//        guard let newValue = numberFormatter.number(from: string)?.intValue else {
//            return
//        }
//
//        model.update(value: newValue)
//    }
//}


class NaturalNumberTextField: BaseField<Int>, UITextFieldDelegate {
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = false
        return formatter
    }()
    
    override func configure(with model: FieldModel<Int>) {
        super.configure(with: model)
        keyboardType = .numberPad
        delegate = self
    }
    
    override func setContentModel(_ model: BaseFieldModel<Int>) {
        super.setContentModel(model)
        
        if model.value != .zero {
            text = String(model.value)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return false
        }
        
        let regEx = "^[1-9][0-9]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let validationResult = predicate.evaluate(with: newText)

        // удаление символов
        if string == "", range.length != .zero, range.location == .zero {
            update(new: String(Int.zero))
            return true
        }
        
        if validationResult {
            update(new: newText)
        }
        
        return validationResult
    }
    
    
    private func update(new string: String) {
        guard let newValue = numberFormatter.number(from: string)?.intValue else {
            return
        }
        model?.content.fieldModel.update(value: newValue)
    }
    
}
