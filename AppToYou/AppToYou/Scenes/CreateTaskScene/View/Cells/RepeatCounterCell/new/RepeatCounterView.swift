import UIKit


class RepeatCounterView: UIView, ValidationErrorDisplayable {
    
    private struct Constants {
        struct Field {
            static let size = CGSize(width: 182, height: 45)
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
        }
        
        struct Button {
            static let spacing: CGFloat = 12
            static let size = CGSize(width: 20, height: 20)
        }
    }

    private let repeatTextField = NaturalNumberTextField(style: StyleManager.standartTextField)
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repeatTextField, minusButton, plusButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = Constants.Button.spacing
        return stack
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {        
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        minusButton.setImage(R.image.minusButtonImage(), for: .normal)
        minusButton.snp.makeConstraints {
            $0.size.equalTo(Constants.Button.size)
        }
        
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        plusButton.setImage(R.image.plusButtonImage(), for: .normal)
        plusButton.snp.makeConstraints {
            $0.size.equalTo(Constants.Button.size)
        }
        
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        repeatTextField.snp.makeConstraints {
            $0.size.equalTo(Constants.Field.size)
        }
    }
    
    func configure(model: NaturalNumberFieldModel) {        
        let contentModel = FieldContentModel(fieldModel: model, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel)
        repeatTextField.configure(with: fieldModel)
    }
    
    func bind(error: ValidationError?) {
        repeatTextField.bind(error: error)
    }
    
    @objc
    private func plusTapped() {
        guard let valueModel = repeatTextField.model?.content.fieldModel as? NaturalNumberFieldModel else {
            return
        }
        
        valueModel.update(value: valueModel.value + 1)
        configure(model: valueModel)
    }
    
    @objc
    private func minusTapped() {
        guard
            let valueModel = repeatTextField.model?.content.fieldModel as? NaturalNumberFieldModel,
            valueModel.value > 1
        else {
            return
        }

        valueModel.update(value: valueModel.value - 1)
        configure(model: valueModel)
    }
    
}
