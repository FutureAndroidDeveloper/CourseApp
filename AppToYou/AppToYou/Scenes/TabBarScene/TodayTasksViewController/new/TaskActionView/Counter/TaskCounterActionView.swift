import UIKit


class TaskCounterActionView: UIView {
    private struct Constants {
        struct Button {
            static let spacing: CGFloat = 12
            static let size = CGSize(width: 20, height: 20)
        }
    }
    
    private var model: TaskCounterActionModel?
    
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, plusButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = Constants.Button.spacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TaskCounterActionModel) {
        self.model = model
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
    }
    
    
    @objc
    private func plusTapped() {
        // TODO: - model.delegate.update
    }
    
    @objc
    private func minusTapped() {
        //
    }
    
}
