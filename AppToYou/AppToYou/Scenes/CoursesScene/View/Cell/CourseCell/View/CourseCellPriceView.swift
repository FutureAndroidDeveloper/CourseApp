import UIKit


class CourseCellPriceView: UIView {
    
    private struct Constants {
        static let coinTitle = "монет"
        static let diamondTitle = "алмазов"
        static let titleInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        static let iconSize = CGSize(width: 16, height: 16)
    }
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
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
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createPriceView(icon: UIImage?, title: String?) -> UIView {
        let priceIcon = UIImageView()
        priceIcon.image = icon
        
        let priceLabel = UILabel()
        priceLabel.text = title
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.textColor = R.color.backgroundTextFieldsColor()
        
        let view = UIView()
        
        view.addSubview(priceIcon)
        priceIcon.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.iconSize)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(priceIcon.snp.trailing).offset(Constants.titleInsets.left)
            $0.top.trailing.bottom.equalToSuperview()
        }
        return view
    }
    
    func configure(with price: Price) {
        contentStack.removeFullyAllArrangedSubviews()
        
        if price.coin > 0 {
            let coinTitle = "\(price.coin.formattedWithSeparator) \(Constants.coinTitle)"
            let coinView = createPriceView(icon: R.image.coinImage(), title: coinTitle)
            contentStack.addArrangedSubview(coinView)
        }
        
        if price.diamond > 0 {
            let diamondTitle = "\(price.diamond.formattedWithSeparator) \(Constants.diamondTitle)"
            let diamondView = createPriceView(icon: R.image.diamondImage(), title: diamondTitle)
            contentStack.addArrangedSubview(diamondView)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
