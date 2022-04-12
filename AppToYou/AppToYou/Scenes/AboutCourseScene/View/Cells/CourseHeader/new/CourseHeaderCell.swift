import UIKit


class CourseHeaderCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        struct BackButton {
            static let edgeInsets = UIEdgeInsets(top: 55, left: 20, bottom: 0, right: 0)
            static let size = CGSize(width: 32, height: 32)
        }
        
        struct InfoView {
            static let edgeInsets = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 15)
            static let spacing: CGFloat = 6
            static let height: CGFloat = 24
            static let minWidth: CGFloat = 78
        }
        
        struct EditButton {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
            static let size = CGSize(width: 38, height: 38)
        }
        
        struct AdminImage {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
            static let size = CGSize(width: 32, height: 32)
        }
        
        struct HeaderImage {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            static let height: CGFloat = 170
            static let cornerRadius: CGFloat = 20
            
            static var bottomInset: CGFloat {
                return EditButton.size.height / 2
            }
        }
    }
    
    private var model: CourseHeaderModel?
    
    private let membersView = HeaderCourseInfoView()
    private let durationView = HeaderCourseInfoView()
    private let coinView = HeaderCourseInfoView()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.HeaderImage.cornerRadius
        imageView.image = R.image.exampleAboutCourse()
        return imageView
    }()
    
    private let adminPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let backActionButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.backBlurButton(), for: .normal)
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.editButtonCourse(), for: .normal)
        return button
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.HeaderImage.edgeInsets)
            $0.height.equalTo(Constants.HeaderImage.height)
        }
        
        let infoContainer = UIStackView(arrangedSubviews: [membersView, durationView, coinView])
        infoContainer.axis = .vertical
        infoContainer.alignment = .trailing
        infoContainer.spacing = Constants.InfoView.spacing
        
        headerImageView.addSubview(infoContainer)
        infoContainer.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.InfoView.edgeInsets)
            $0.width.height.greaterThanOrEqualTo(0)
        }
        
        membersView.snp.makeConstraints {
            $0.height.equalTo(Constants.InfoView.height)
            $0.width.greaterThanOrEqualTo(Constants.InfoView.minWidth)
        }
        durationView.snp.makeConstraints {
            $0.height.equalTo(Constants.InfoView.height)
            $0.width.greaterThanOrEqualTo(Constants.InfoView.minWidth)
        }
        coinView.snp.makeConstraints {
            $0.height.equalTo(Constants.InfoView.height)
            $0.width.greaterThanOrEqualTo(Constants.InfoView.minWidth)
        }
        
        headerImageView.addSubview(backActionButton)
        backActionButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Constants.BackButton.edgeInsets)
            $0.size.equalTo(Constants.BackButton.size)
        }
        
        headerImageView.addSubview(adminPhotoView)
        adminPhotoView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(Constants.AdminImage.edgeInsets)
            $0.size.equalTo(Constants.AdminImage.size)
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(Constants.EditButton.edgeInsets)
            $0.size.equalTo(Constants.EditButton.size)
        }
        
        headerImageView.isUserInteractionEnabled = true
        backActionButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseHeaderModel else {
            return
        }
        self.model = model
        
        var durationTitle = String()
        
        if let duration = model.duration {
            let year = duration.year == 0 ? "" : "\(duration.year) год"
            let month = duration.year == 0 ? "" : "\(duration.month) мес"
            let day = duration.year == 0 ? "" : "\(duration.day) дн"
            durationTitle = "\(year) \(month) \(day)"
        }
        
        if !durationTitle.components(separatedBy: .whitespaces).joined().isEmpty {
            let durationModel = HeaderCourseInfoViewModel(title: durationTitle,
                                                          icon: R.image.timeOclockImage()?.withRenderingMode(.alwaysTemplate))
            durationView.configure(with: durationModel)
            durationView.isHidden = false
        } else {
            durationView.isHidden = true
        }
        
        if let price = model.price, price.coin > 0 || price.diamond > 0 {
            let coinModel = HeaderCourseInfoViewModel(title: price.coin.formattedWithSeparator, icon: R.image.coinImage())
            coinView.configure(with: coinModel)
            coinView.isHidden = false
        } else {
            coinView.isHidden = true
        }
        
        let membersModel = HeaderCourseInfoViewModel(title: model.membersCount.formattedWithSeparator,
                                                     icon: R.image.peopleImage()?.withRenderingMode(.alwaysTemplate))
        membersView.configure(with: membersModel)
        
        editButton.isHidden = !model.isEditable
        adminPhotoView.isHidden = model.isEditable
        adminPhotoView.image = model.adminPhoto
        headerImageView.image = model.coursePhoto
    }

    @objc
    private func backTapped() {
        model?.backTapped()
    }

    @objc
    private func editButtonTapped() {
        model?.editTapped()
    }
    
}
