import UIKit


class ChooseTaskTypeCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        
        static let contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        static let titleInsets = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        static let descriptionInsets = UIEdgeInsets(top: 3, left: 12, bottom: 12, right: 12)
        
        struct Icon {
            static let insets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            static let size = CGSize(width: 48, height: 48)
        }
        
        struct Select {
            static let insets = UIEdgeInsets(top: -2, left: -2, bottom: -2, right: -2)
            static let borderWidth: CGFloat = 2
            static let cornerRadius: CGFloat = 22
        }
    }
    
    private let titleLabel = LabelFactory.getChooseTaskTypeTitleLable(title: nil)
    private let descriptionLabel = LabelFactory.getChooseTaskDescriptionLable(title: nil)
    private let typeImageView = UIImageView()

    private let backContentView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTableCellColor()
        return view
    }()

    private let selectedBackView: UIView = {
        let view = UIView()
        view.layer.borderColor = R.color.textColorSecondary()?.cgColor
        view.layer.cornerRadius = Constants.Select.cornerRadius
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backContentView.layer.cornerRadius = 20
        selectedBackView.frame = backContentView.frame.inset(by: Constants.Select.insets)
        selectedBackView.layer.borderWidth = Constants.Select.borderWidth
    }
    
    private func configure() {
        contentView.addSubview(backContentView)
        backContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.contentInsets)
        }
        
        backContentView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constants.Icon.insets)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.Icon.size)
        }
        
        backContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(typeImageView.snp.trailing).offset(Constants.titleInsets.left)
            $0.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        backContentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(typeImageView.snp.trailing).offset(Constants.descriptionInsets.left)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.descriptionInsets.top)
            $0.trailing.bottom.equalToSuperview().inset(Constants.descriptionInsets)
        }
        selectedBackgroundView = selectedBackView
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? ChooseTaskTypeModel else {
            return
        }
        typeImageView.image = model.icon
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
//    func select() {
//        backContentView.layer.borderWidth = 2
//    }
//
//    func deselect() {
//        backContentView.layer.borderWidth = 0
//    }
}
