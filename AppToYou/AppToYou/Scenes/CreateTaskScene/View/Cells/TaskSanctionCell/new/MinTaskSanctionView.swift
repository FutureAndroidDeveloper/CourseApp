import UIKit


class MinTaskSanctionView: UIView {
    
    private struct Constants {
        static let minText = "*минимум"
        static let betweenOffset: CGFloat = 6
        static let coinSize = CGSize(width: 12, height: 12)
    }
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coinImage()
        return imageView
    }()
    
    private let minSanctionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
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
        addSubview(minSanctionLabel)
        minSanctionLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        addSubview(coinImageView)
        coinImageView.snp.makeConstraints {
            $0.leading.equalTo(minSanctionLabel.snp.trailing).offset(Constants.betweenOffset)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.coinSize)
        }
    }
    
    func configure(min: Int) {
        minSanctionLabel.text = "\(Constants.minText) \(min)"
    }
    
}
