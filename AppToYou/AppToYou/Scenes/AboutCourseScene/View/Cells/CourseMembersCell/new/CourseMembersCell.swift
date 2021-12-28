import UIKit


class CourseMembersCell : UITableViewCell, InflatableView {
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 22, left: 20, bottom: 0, right: 20)
        
        struct Detailed {
            static let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
            static let iconSize = CGSize(width: 14, height: 14)
            static let betweenOffset: CGFloat = 4
        }
        
        struct Members {
            static let edgeInsets = UIEdgeInsets(top: 24, left: 20, bottom: 7, right: 0)
            static let height: CGFloat = 50
        }
    }
    
    private var model: CourseMembersModel?
    
    private let membersView = MembersView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Следите за успехами участников курса и делитесь своими!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let detailedLabel: UILabel = {
        let label = UILabel()
        label.text = "Посмотреть"
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let detailedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.shareImage()
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
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(membersView)
        membersView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Members.edgeInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.Members.edgeInsets)
            $0.height.equalTo(Constants.Members.height)
        }
        
        let detailedStack = UIStackView(arrangedSubviews: [detailedLabel, detailedImageView])
        detailedStack.axis = .horizontal
        detailedStack.spacing = Constants.Detailed.betweenOffset

        contentView.addSubview(detailedStack)
        detailedStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.Detailed.edgeInsets)

            $0.leading.equalTo(membersView.snp.trailing).offset(Constants.Detailed.edgeInsets.left)
            $0.centerY.equalTo(membersView)
        }

        detailedImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.Detailed.iconSize)
        }

        detailedStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(membersDidTap)))
        membersView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(membersDidTap)))
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseMembersModel else {
            return
        }
        self.model = model
        membersView.configure(with: model.model)
    }
    
    @objc
    private func membersDidTap() {
        model?.membersTapped()
    }
    
}
