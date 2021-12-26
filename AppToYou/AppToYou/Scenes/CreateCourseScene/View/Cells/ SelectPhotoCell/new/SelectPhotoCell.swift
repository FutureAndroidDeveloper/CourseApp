import UIKit


class SelectPhotoCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        struct Photo {
            static let insets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
            static let height: CGFloat = 125
        }
        
        struct TypeImage {
            static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 12)
            static let size = CGSize(width: 38, height: 38)
        }
    }
    
    private var model: SelectPhotoModel?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Обложка курса")

    private let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.coursePhotoExample()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let typeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.chooseCourseImage()
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
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Photo.insets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Photo.insets)
            $0.height.equalTo(Constants.Photo.height)
        }

        photoImageView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Constants.TypeImage.insets)
            $0.size.equalTo(Constants.TypeImage.size)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
        photoImageView.layer.cornerRadius = 20
        photoImageView.clipsToBounds = true
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SelectPhotoModel else {
            return
        }
        self.model = model
        photoImageView.image = model.photoImage
        typeImageView.isHidden = model.photoImage == model.defaultImage
    }
    
    @objc
    private func selectPhoto() {
        model?.pickImage()
    }
    
}
