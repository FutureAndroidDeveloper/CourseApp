import UIKit


class CourseDescriptionHeaderView: UITableViewCell, InflatableView {
    private struct Constants {
        static let titleEdgeInsets = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        static let costEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 20)
        static let memebersEdgeInsets = UIEdgeInsets(top: 18, left: 20, bottom: 0, right: 15)
        static let descriptionEdgeInsets = UIEdgeInsets(top: 24, left: 20, bottom: 25, right: 20)
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 2
        return label
    }()
    
    private let costView = CourseHeaderCostView()
    private let memebersView = CourseCellInfoView()
    private let likesView = CourseCellInfoView()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(costView)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Constants.titleEdgeInsets)
            $0.trailing.equalToSuperview().inset(Constants.titleEdgeInsets).priority(.low)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.trailing.equalTo(costView.snp.leading).offset(Constants.costEdgeInsets.left)
        }
        nameLabel.snp.contentCompressionResistanceHorizontalPriority = 240
        
        costView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.costEdgeInsets)
            $0.centerY.equalTo(nameLabel)
        }
        
        contentView.addSubview(memebersView)
        memebersView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.memebersEdgeInsets.top)
            $0.leading.equalToSuperview().inset(Constants.memebersEdgeInsets)
        }
        
        contentView.addSubview(likesView)
        likesView.snp.makeConstraints {
            $0.leading.equalTo(memebersView.snp.trailing).offset(Constants.memebersEdgeInsets.right)
            $0.centerY.equalTo(memebersView)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(memebersView.snp.bottom).offset(Constants.descriptionEdgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.descriptionEdgeInsets)
        }
        
        let style = HeaderCourseInfoViewStyle(
            titleFont: UIFont.systemFont(ofSize: 13, weight: .bold),
            textColor: R.color.textSecondaryColor(),
            iconTintColor: R.color.textSecondaryColor()
        )
        memebersView.setStyle(style)
        likesView.setStyle(style)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseDescriptionHeaderModel else {
            return
        }
        nameLabel.text = model.name
        memebersView.configure(with: HeaderCourseInfoViewModel(title: model.members.formattedWithSeparator, icon: R.image.countOfPeopleImage()))
        likesView.configure(with: HeaderCourseInfoViewModel(title: model.likes.formattedWithSeparator, icon: R.image.fillGrayLike()))
        descriptionLabel.text = model.courseDescription
        
        if let price = model.price {
            let priceValue = price.diamond > 0 ? price.diamond : price.coin
            let icon = price.diamond > 0 ? R.image.diamondImage() : R.image.coinImage()
            let costModel = CourseHeaderCostModel(price: priceValue.formattedWithSeparator, icon: icon)
            costView.configure(with: costModel)
        } else {
            costView.isHidden = true
        }
        
        layoutIfNeeded()
    }
    
}
