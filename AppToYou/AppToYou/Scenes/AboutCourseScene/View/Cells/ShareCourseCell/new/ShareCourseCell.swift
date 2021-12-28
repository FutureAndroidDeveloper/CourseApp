import UIKit


class ShareCourseCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 35, left: 20, bottom: 35, right: 0)
        static let shareInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 25)
        static let shareSize = CGSize(width: 38, height: 38)
    }
    
    private var model: ShareCourseModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поделись курсом с друзьями. Меняйтесь вместе!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareCourseImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
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

        contentView.addSubview(shareImageView)
        shareImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.shareInsets)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(Constants.shareInsets.left)
            $0.centerY.equalTo(titleLabel)
        }
        
        titleLabel.isUserInteractionEnabled = true
        shareImageView.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareDidTap)))
        shareImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareDidTap)))
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? ShareCourseModel else {
            return
        }
        self.model = model
    }
    
    @objc
    private func shareDidTap() {
        model?.shareTapped()
    }
    
}
