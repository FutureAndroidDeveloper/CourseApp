import UIKit


class DeleteCourseCell : UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 32, left: 20, bottom: 0, right: 0)
        static let betweenOffset: CGFloat = 9
        static let imageSize = CGSize(width: 24, height: 24)
    }
    
    private var model: DeleteCourseModel?

    private let deleteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = R.image.deleteImage()?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.color.failureColor()
        return imageView
    }()

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Удалить курс"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.failureColor()
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(deleteImageView)
        deleteImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.size.equalTo(Constants.imageSize)
        }
        addTapHandler(for: deleteImageView)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteImageView.snp.trailing).offset(Constants.betweenOffset)
            $0.centerY.equalTo(deleteImageView)
        }
        addTapHandler(for: titleLabel)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? DeleteCourseModel else {
            return
        }
        
        self.model = model
    }
    
    private func addTapHandler(for view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeCourse))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func removeCourse() {
        model?.deleteHandler()
    }
    
}
