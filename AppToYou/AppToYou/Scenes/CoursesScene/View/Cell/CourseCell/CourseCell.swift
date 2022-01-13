import UIKit


class CourseCell: UITableViewCell {
    
    private struct Constants {
        static let contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20)
        static let likeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 11, right: 12)
        static let priceInsets = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 0)
        
        static let typeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        static let nameInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 20)
        static let descriptionInsets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        static let categoriesInsets = UIEdgeInsets(top: 32, left: 20, bottom: 16, right: 0)
        
        static let coursePhotoheight: CGFloat = 128
        static let courseTypePostfix = "курс"
        static let cornerRadius: CGFloat = 20
        
        struct OwnerPhoto {
            static let insets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 12)
            static let size = CGSize(width: 32, height: 32)
        }
        
        struct TypeIcon {
            static let insets = UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 20)
            static let size = CGSize(width: 24, height: 24)
        }
    }
    
    private var model: CourseCellModel?

    private let contentCellView = UIView()
    private let courseImageView = UIImageView()
    private let gradientImageView = ATYGradientImageView(frame: .zero)
    
    private let ownerImageView = UIImageView()
    private let memebersView = CourseCellInfoView()
    private let likesView = CourseCellInfoView()
    private let priceView = CourseCellPriceView()
    
    private let nameLabel = LabelFactory.getAddTaskTitleLabel(title: nil)
    private let descriptionLabel = LabelFactory.getAddTaskDescriptionLabel(title: nil)
    private let categoriesView = CourseCellCategoriesView()
    private let typeIconView = UIImageView()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.textColorSecondary()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        courseImageView.image = model?.courseImage
        ownerImageView.image = model?.ownerImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentCellView.layer.cornerRadius = Constants.cornerRadius
        courseImageView.layer.cornerRadius = Constants.cornerRadius
        ownerImageView.layer.cornerRadius = ownerImageView.bounds.height / 2
    }
    
    private func configure() {
        contentCellView.backgroundColor = R.color.backgroundTextFieldsColor()
        courseImageView.contentMode = .scaleAspectFill
        descriptionLabel.numberOfLines = 3
        ownerImageView.clipsToBounds = true
        ownerImageView.layer.masksToBounds = true
        courseImageView.clipsToBounds = true
        courseImageView.layer.masksToBounds = true
        typeIconView.tintColor = R.color.textColorSecondary()
        
        contentView.addSubview(contentCellView)
        contentCellView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.contentInsets)
        }
        
        contentCellView.addSubview(courseImageView)
        courseImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(Constants.coursePhotoheight)
        }
        
        courseImageView.addSubview(gradientImageView)
        gradientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        courseImageView.addSubview(ownerImageView)
        ownerImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.OwnerPhoto.insets)
            $0.size.equalTo(Constants.OwnerPhoto.size)
        }
        
        courseImageView.addSubview(likesView)
        likesView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Constants.likeInsets)
        }
        
        courseImageView.addSubview(memebersView)
        memebersView.snp.makeConstraints {
            $0.trailing.equalTo(likesView.snp.leading).inset(Constants.likeInsets.left)
            $0.centerY.equalTo(likesView)
        }
        
        courseImageView.addSubview(priceView)
        priceView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(Constants.priceInsets)
            $0.height.width.greaterThanOrEqualTo(0)
        }
        
        contentCellView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(courseImageView.snp.bottom).offset(Constants.typeInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.typeInsets)
        }
        
        contentCellView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(Constants.nameInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.nameInsets)
        }
        
        contentCellView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.nameInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.nameInsets)
        }
        
        contentCellView.addSubview(categoriesView)
        categoriesView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.categoriesInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.categoriesInsets)
        }
        
        contentCellView.addSubview(typeIconView)
        typeIconView.snp.makeConstraints {
            $0.leading.equalTo(categoriesView.snp.trailing).offset(Constants.TypeIcon.insets.left)
            $0.trailing.bottom.equalToSuperview().inset(Constants.TypeIcon.insets)
            $0.size.equalTo(Constants.TypeIcon.size)
        }
    }
    
    func configure(with model: CourseCellModel) {
        self.model = model
        
        courseImageView.image = model.courseImage
        ownerImageView.image = model.ownerImage
        
        let likesModel = HeaderCourseInfoViewModel(
            title: model.course.likes.formattedWithSeparator,
            icon: R.image.likesView()?.withRenderingMode(.alwaysTemplate)
        )
        likesView.configure(with: likesModel)
        
        let membersModel = HeaderCourseInfoViewModel(
            title: model.course.usersAmount.formattedWithSeparator,
            icon: R.image.peopleImage()?.withRenderingMode(.alwaysTemplate)
        )
        memebersView.configure(with: membersModel)
        
        let price = Price(coin: model.course.coinPrice, diamond: model.course.diamondPrice)
        priceView.configure(with: price)
        
        let typeTitle = model.course.courseType.title?.lowercased() ?? String()
        typeLabel.text = "\(typeTitle) \(Constants.courseTypePostfix)"
        
        nameLabel.text = model.course.name
        descriptionLabel.text = model.course.description
        
        let categories = [model.course.courseCategory1, model.course.courseCategory2, model.course.courseCategory3]
        categoriesView.configure(with: categories.filter { $0 != .EMPTY })
        
        typeIconView.image = model.getTypeIcon()
    }
    
}

