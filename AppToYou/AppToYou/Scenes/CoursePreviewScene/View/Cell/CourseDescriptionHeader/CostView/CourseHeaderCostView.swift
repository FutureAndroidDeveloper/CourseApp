import UIKit


class CourseHeaderCostView: UIView {
    private struct Constants {
        struct Icon {
            static let offset: CGFloat = 8
            static let size = CGSize(width: 23, height: 23)
        }
    }
    
    private let coinIconView = UIImageView()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = R.color.textColorSecondary()
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        addSubview(coinIconView)
        coinIconView.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.trailing).offset(Constants.Icon.offset)
            $0.trailing.centerY.equalToSuperview()
            $0.size.equalTo(Constants.Icon.size)
        }
    }
    
    func configure(with model: CourseHeaderCostModel) {
        priceLabel.text = model.price
        coinIconView.image = model.icon
    }
    
}
