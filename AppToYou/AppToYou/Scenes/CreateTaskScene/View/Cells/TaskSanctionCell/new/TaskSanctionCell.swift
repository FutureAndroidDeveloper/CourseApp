import UIKit


class TaskSanctionCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
        
        struct Field {
            static let size = CGSize(width: 182, height: 45)
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 11)
            static let iconInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 11)
        }
        
        struct Question {
            static let size = CGSize(width: 30, height: 30)
            static let offset: CGFloat = 12
        }
    }
    
    private var callbackText: ((String) -> Void)?
    private var questionCallback: (() -> Void)?

    private let sanctionField = NaturalNumberTextField(style: StyleManager.standartTextField)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.penaltyForNonCompliance()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let questionButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.questionButton(), for: .normal)
        return button
    }()

    private let switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    
    // MARK: - Initialization
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
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.bottom)
            $0.leading.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.size.equalTo(Constants.Field.size)
        }

        contentView.addSubview(questionButton)
        questionButton.addTarget(self, action: #selector(questionButtonAction), for: .touchUpInside)
        questionButton.snp.makeConstraints {
            $0.leading.equalTo(sanctionField.snp.trailing).offset(Constants.Question.offset)
            $0.size.equalTo(Constants.Question.size)
            $0.centerY.equalTo(sanctionField)
        }

        contentView.addSubview(switchButton)
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.edgeInsets.left)
            $0.centerY.equalTo(questionButton)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskSanctionModel else {
            return
        }
        
        let coinImageView = UIImageView()
        coinImageView.image = R.image.coinImage()
        let rightModel = FieldAdditionalContentModel(contentView: coinImageView, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.model, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, rightContent: rightModel)
        
        sanctionField.configure(with: fieldModel)
    }
    
    @objc
    private func questionButtonAction() {
        questionCallback?()
    }
    
}
