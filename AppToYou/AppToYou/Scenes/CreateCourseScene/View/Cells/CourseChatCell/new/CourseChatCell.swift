import UIKit


class CourseChatCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let descriptionInsets = UIEdgeInsets(top: 9, left: 20, bottom: 0, right: 69)
        
        struct Link {
            static let fieldInsets = UIEdgeInsets(top: 16, left: 20, bottom: 32, right: 20)
            
            static let textInsets = UIEdgeInsets(top: 11, left: 5, bottom: 13, right: 5)
            static let iconInsets = UIEdgeInsets(top: 12, left: 10, bottom: 10, right: 12)
        }
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Чат курса")
    private let linkField = TextField(style: StyleManager.standartTextField)

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте чат курса в Telegram и вставьте ссылку ниже для вступления в нее участников"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 0
        return label
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

        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.descriptionInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.descriptionInsets)
        }

        contentView.addSubview(linkField)
        linkField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.Link.fieldInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Link.fieldInsets)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseChatModel else {
            return
        }
        
        let linkIconView = UIImageView()
        linkIconView.image = R.image.chatLink()
        
        let messangerIconView = UIImageView()
        messangerIconView.image = R.image.telegram()
        
        let linkModel = FieldAdditionalContentModel(contentView: linkIconView, insets: Constants.Link.iconInsets)
        let messangerModel = FieldAdditionalContentModel(contentView: messangerIconView, insets: Constants.Link.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.fieldModel, insets: Constants.Link.textInsets)
        
        let fieldModel = FieldModel(content: contentModel, leftContent: linkModel, rightContent: messangerModel)
        linkField.configure(with: fieldModel)
        
        model.errorNotification = { [weak self] error in
            self?.linkField.bind(error: error)
            self?.bind(error: error)
        }
    }
    
}
