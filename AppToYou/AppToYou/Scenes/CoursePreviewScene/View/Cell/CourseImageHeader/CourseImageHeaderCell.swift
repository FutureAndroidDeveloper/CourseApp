import UIKit


class CourseImageHeaderCell: UITableViewCell, InflatableView {
    private struct Constants {
        struct OwnerImage {
            static let edgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16)
            static let size = CGSize(width: 32, height: 32)
        }
        
        struct CourseImage {
            static let height: CGFloat = 170
            static let cornerRadius: CGFloat = 20
        }
    }
    
    private let courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let ownerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ownerImageView.layer.cornerRadius = ownerImageView.bounds.height / 2
    }

    private func setup() {
        contentView.addSubview(courseImageView)
        courseImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.CourseImage.height)
        }
        
        courseImageView.addSubview(ownerImageView)
        ownerImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.OwnerImage.edgeInsets)
            $0.size.equalTo(Constants.OwnerImage.size)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseImageHeaderModel else {
            return
        }
        courseImageView.image = model.courseImage
        ownerImageView.image = model.ownerImage
    }
}
