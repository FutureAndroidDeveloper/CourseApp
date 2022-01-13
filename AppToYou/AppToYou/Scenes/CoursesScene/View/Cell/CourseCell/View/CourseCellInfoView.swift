import UIKit


class CourseCellInfoView: UIView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        static let iconSize = CGSize(width: 16, height: 16)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.backgroundAppColor()
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = R.color.backgroundAppColor()
        return imageView
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.iconSize)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(Constants.titleInsets.left)
            $0.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: HeaderCourseInfoViewModel) {
        titleLabel.text = model.title
        iconView.image = model.icon
    }
    
}
