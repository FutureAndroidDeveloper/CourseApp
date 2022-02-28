import UIKit


enum CourseTaskCurrency {
    case coin
    case diamond
    
    var icon: UIImage? {
        switch self {
        case .coin:
            return R.image.coinImage()
        case .diamond:
            return R.image.diamondImage()
        }
    }
}

class CourseTaskHintModel {
    let title: String
    let currency: CourseTaskCurrency
    
    init(title: String, currency: CourseTaskCurrency) {
        self.title = title
        self.currency = currency
    }
    
}

class CourseTaskHintView: UIView {
    private let nameLabel = UILabel()
    private let currencyIcon = UIImageView()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = frame.height / 2
    }
    
    private func setup() {
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(currencyIcon)
        
        nameLabel.backgroundColor = .gray
        nameLabel.textAlignment = .center
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        currencyIcon.snp.makeConstraints {
            $0.width.equalTo(16)
        }
    }
    
    func configure(with model: CourseTaskHintModel) {
        nameLabel.text = model.title
        currencyIcon.image = model.currency.icon
        setNeedsLayout()
        layoutIfNeeded()
    }
}
