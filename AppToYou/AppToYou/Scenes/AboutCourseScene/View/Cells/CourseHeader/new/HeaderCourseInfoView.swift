import UIKit

class HeaderCourseInfoViewModel {
    let title: String?
    let icon: UIImage?
    
    init(title: String?, icon: UIImage?) {
        self.title = title
        self.icon = icon
    }
}

class HeaderCourseInfoViewStyle {
    let titleFont: UIFont?
    let textColor: UIColor?
    let iconTintColor: UIColor?
    
    init(titleFont: UIFont?, textColor: UIColor?, iconTintColor: UIColor?) {
        self.titleFont = titleFont
        self.textColor = textColor
        self.iconTintColor = iconTintColor
    }
}

class HeaderCourseInfoView: UIView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 6)
        struct Icon {
            static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            static let size = CGSize(width: 16, height: 16)
        }
    }
    
    private let iconView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    
    init() {
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
        backgroundColor = R.color.courseHeaderInfoColor()
        iconView.tintColor = R.color.titleTextColor()
        
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.Icon.insets)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.Icon.size)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.titleInsets)
            $0.trailing.equalTo(iconView.snp.leading).offset(-Constants.titleInsets.right)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with model: HeaderCourseInfoViewModel) {
        titleLabel.text = model.title
        iconView.image = model.icon
    }
    
}
