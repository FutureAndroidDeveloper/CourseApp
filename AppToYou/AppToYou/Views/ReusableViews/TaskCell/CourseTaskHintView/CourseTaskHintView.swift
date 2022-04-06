import UIKit


class CourseTaskHintView: UIView {
    private struct Constants {
        static let labelPadding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        static let iconSize = CGSize(width: 15, height: 15)
    }
    private let currencyIcon = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = PaddingLabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.backgroundColor = R.color.cardsColor()
        label.leftInset = Constants.labelPadding.left
        label.rightInset = Constants.labelPadding.right
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 6
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
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        currencyIcon.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
        }
    }
    
    func configure(with model: CourseTaskHintModel) {
        nameLabel.text = model.title
        currencyIcon.image = model.currency.icon
        setNeedsLayout()
        layoutIfNeeded()
    }
}
