import UIKit

//
//class PaddingTextField: UITextField, UITextFieldDelegate {
//    private let textPadding = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
//    
//    
//    init() {
//        super.init(frame: .zero)
//        setup()
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
//        backgroundColor = R.color.backgroundTextFieldsColor()
//        textColor = R.color.titleTextColor()
//        delegate = self
//    }
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: textPadding)
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: textPadding)
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: textPadding)
//    }
//    
//}
