import UIKit


class SelectDateTextField: UITextField {
    
    private struct Constants {
        static let fieldSize = CGSize(width: 158, height: 44)
        static let textInsets = UIEdgeInsets(top: 11, left: 8, bottom: 13, right: 20)
        static let imageInset: CGFloat = 18
    }
    
    private let imageView = UIImageView()
    
    private var textPadding: UIEdgeInsets {
        let leftInset = leftViewRect(forBounds: bounds).maxX + Constants.textInsets.left
        var insets = Constants.textInsets
        insets.left = leftInset
        return insets
    }
    
    override var intrinsicContentSize: CGSize {
        return Constants.fieldSize
    }
    
    init(style: SelectDateFieldStyle = .standart) {
        super.init(frame: .zero)
        configure(with: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var imageRect = super.leftViewRect(forBounds: bounds)
        imageRect.origin.x += Constants.imageInset
        return imageRect
    }

    private func configure(with style: SelectDateFieldStyle) {
        font = UIFont.systemFont(ofSize: 15)
        backgroundColor = style.backgroundColor
        textColor = style.textColor
        
        imageView.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = style.imageColor

        leftViewMode = .always
        leftView = imageView
    }
}
