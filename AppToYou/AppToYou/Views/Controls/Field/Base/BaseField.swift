import UIKit


/**
 Базовая реализация текстового поля с возможность настраивать текст, правый, левый контент и их отступы.
 */
class BaseField<Value>: UITextField, ValidationErrorDisplayable {
    
    private(set) var model: FieldModel<Value>?
    private var style: FieldStyle
    
    private var textPadding: UIEdgeInsets {
        guard let contentModel = model?.content else {
            return .zero
        }
        
        let leftInset = leftViewRect(forBounds: bounds).maxX + contentModel.insets.left
        let rightInset = bounds.width - rightViewRect(forBounds: bounds).minX + contentModel.insets.right
        var insets = contentModel.insets
        insets.left = leftInset
        insets.right = rightInset
        
        return insets
    }
    
    
    init(style: FieldStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setup() {
        updateStyle(style)
    }
    
    func updateStyle(_ style: FieldStyle) {
        self.style = style
        backgroundColor = style.backgroundColor
        textColor = style.textColor
    }
    
    func configure(with model: FieldModel<Value>) {
        self.model = model
        setLeftContent(model.leftContent)
        setRightContent(model.rightContent)
        setContentModel(model.content.fieldModel)
    }
    
    /**
     Установка текстового значения поля.
     
     Необходимо переопределить в классе наследнике поведение для свойства `text`.
     */
    func setContentModel(_ model: BaseFieldModel<Value>) {
        placeholder = model.placeholder
    }
    
    /**
     Установить левый контент для поля.
     
     - parameters:
        - content: устанавливаемый контент. Если `nil` - отключение контента.
     */
    func setLeftContent(_ content: FieldAdditionalContentModel?) {
        model?.leftContent = content
        
        if let leftModel = content {
            leftViewMode = .always
            leftView = leftModel.contentView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
    
    /**
     Установить правый контент для поля.
     
     - parameters:
        - content: устанавливаемый контент. Если `nil` - отключение контента.
     */
    func setRightContent(_ content: FieldAdditionalContentModel?) {
        model?.rightContent = content
        
        if let rightModel = content {
            rightViewMode = .always
            rightView = rightModel.contentView
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
    
    func bind(error: ValidationError?) {
        if let _ = error {
            layer.borderWidth = 1
            layer.borderColor = R.color.failureColor()?.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
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
        guard let leftContent = model?.leftContent else {
            return super.leftViewRect(forBounds: bounds)
        }
        
        var newRect = bounds.inset(by: leftContent.insets)
        newRect.size.width = newRect.height
        return newRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightContent = model?.rightContent else {
            return super.rightViewRect(forBounds: bounds)
        }
        
        var newRect = bounds.inset(by: rightContent.insets)
        newRect.size.width = newRect.height
        
        let offset = bounds.width - (newRect.width + newRect.minX + rightContent.insets.right)
        return newRect.offsetBy(dx: offset, dy: 0)
    }
    
}

