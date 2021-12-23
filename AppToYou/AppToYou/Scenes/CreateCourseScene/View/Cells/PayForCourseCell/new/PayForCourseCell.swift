import UIKit


class PayForCourseCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 49, bottom: 32, right: 20)
        
        struct Field {
            static let size = CGSize(width: 182, height: 45)
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 11)
            static let iconInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 11)
        }
    }
    
    private let sanctionField = NaturalNumberTextField(style: StyleManager.standartTextField)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата за вступление в курс"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }

        contentView.addSubview(sanctionField)
        sanctionField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.size.equalTo(Constants.Field.size)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? PayForCourseModel else {
            return
        }
        
        let coinImageView = UIImageView()
        coinImageView.image = R.image.coinImage()
        let rightModel = FieldAdditionalContentModel(contentView: coinImageView, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.model, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, rightContent: rightModel)
        
        sanctionField.configure(with: fieldModel)
    }
    
}
