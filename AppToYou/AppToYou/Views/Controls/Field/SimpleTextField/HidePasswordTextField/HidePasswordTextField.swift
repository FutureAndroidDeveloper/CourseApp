import UIKit



class HidePasswordTextField: UIView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 10)
        static let iconInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 16)
        
    }
    
    private let field = FieldFactory.shared.getTextField()
    private let eyeButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        field.textContentType = .password
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        
        addSubview(field)
        field.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        eyeButton.setImage(R.image.eye(), for: .normal)
        eyeButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
    }
    
    func configure(with model: BaseFieldModel<String>) {
        let rightModel = FieldAdditionalContentModel(contentView: eyeButton, insets: Constants.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model, insets: Constants.textInsets)
        let fieldModel = FieldModel(content: contentModel, rightContent: rightModel)
        
        field.configure(with: fieldModel)
    }
    
    func bind(error: ValidationError?) {
        field.bind(error: error)
    }
    
    @objc
    private func toggleShowHide() {
        field.isSecureTextEntry.toggle()
        if field.isSecureTextEntry {
            eyeButton.setImage(R.image.eye(), for: .normal)
        } else {
            eyeButton.setImage(R.image.openEye(), for: .normal)
        }
    }
    
}
