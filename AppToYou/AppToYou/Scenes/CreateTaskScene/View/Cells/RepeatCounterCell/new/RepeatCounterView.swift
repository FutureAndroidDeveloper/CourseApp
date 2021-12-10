import UIKit


class RepeatCounterView: UIView {
    
    private struct Constants {
        static let space: CGFloat = 12
        static let buttonSize = CGSize(width: 20, height: 20)
    }

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [repeatTextField, minusButton, plusButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = Constants.space
        return stack
    }()
    
    private let repeatTextField = NaturalNumberTextField()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    
    private var valueModel: NaturalNumberFieldModel
    
    
    convenience init() {
        self.init(valueModel: NaturalNumberFieldModel())
    }
    
    init(valueModel: NaturalNumberFieldModel) {
        self.valueModel = valueModel
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
            $0.size.equalTo(Constants.buttonSize)
        }
        
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        plusButton.setImage(R.image.plusButtonImage(), for: .normal)
        plusButton.snp.makeConstraints {
            $0.size.equalTo(Constants.buttonSize)
        }
        
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(model: NaturalNumberFieldModel) {
        valueModel = model
        repeatTextField.configure(with: model)
    }
    
    @objc
    private func plusTapped() {
        valueModel.update(value: valueModel.value + 1)
        repeatTextField.configure(with: valueModel)
    }
    
    @objc
    private func minusTapped() {
        if valueModel.value <= 1 {
            return
        }
        valueModel.update(value: valueModel.value - 1)
        repeatTextField.configure(with: valueModel)
    }
    
}
