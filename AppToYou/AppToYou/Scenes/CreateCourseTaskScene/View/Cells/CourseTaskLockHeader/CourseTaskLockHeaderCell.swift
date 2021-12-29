import UIKit


class CourseTaskLockHeaderCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 12, left: 24, bottom: 20, right: 0)
        static let lockInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 24)
        static let lockSize = CGSize(width: 24, height: 24)
        static let separatorHeight: CGFloat = 1
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите на замок, чтобы сделать параметр недоступным для редактирования пользователем"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.openCourseImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.textColorSecondary()
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.separatorColor()
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(lockImageView)
        lockImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(Constants.lockInsets.left)
            $0.trailing.equalToSuperview().inset(Constants.lockInsets)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(Constants.lockSize)
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constants.separatorHeight)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let _ = model as? CourseTaskLockModel else {
            return
        }
    }
    
}
