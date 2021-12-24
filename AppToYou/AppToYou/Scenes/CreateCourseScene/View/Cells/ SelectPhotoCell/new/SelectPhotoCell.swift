import UIKit


class SelectPhotoCell: UITableViewCell, InflatableView {
    
    private var model: SelectPhotoModel?
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Обложка курса"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

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
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)


        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
        photoImageView.layer.cornerRadius = 20
        photoImageView.clipsToBounds = true
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(125)
            make.bottom.equalToSuperview().offset(-15)
        }

        photoImageView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.height.equalTo(38)
        }
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
