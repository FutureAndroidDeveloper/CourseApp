import UIKit


class PayForCourseCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 49, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 49, bottom: 32, right: 0)
        
        struct Field {
            static let width: CGFloat = 182
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 11)
            static let iconInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 11)
        }
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Оплата за вступление в курс")
    private let sanctionField = NaturalNumberTextField(style: StyleManager.standartTextField)

    
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }

        contentView.addSubview(sanctionField)
        sanctionField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.fieldInsets)
            $0.width.equalTo(Constants.Field.width)
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
        
        model.errorNotification = { [weak self] error in
            self?.sanctionField.bind(error: error)
            self?.bind(error: error)
        }
    }
    
}
