import UIKit


class TaskSanctionCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let edgeInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let minInsets = UIEdgeInsets(top: 6, left: 20, bottom: 0, right: 20)
        
        struct Field {
            static let width: CGFloat = 182
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 11)
            static let iconInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 11)
        }
        
        struct Question {
            static let size = CGSize(width: 30, height: 30)
            static let offset: CGFloat = 12
        }
    }
    
    private var model: TaskSanctionModel?

    private let titleLabel = LabelFactory.getTitleLabel(title: R.string.localizable.penaltyForNonCompliance())
    private let sanctionField = FieldFactory.shared.getNaturalNumberField()
    private let minLabel = MinTaskSanctionView()

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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.width.equalTo(Constants.Field.width)
        }

        contentView.addSubview(questionButton)
        questionButton.snp.makeConstraints {
            $0.leading.equalTo(sanctionField.snp.trailing).offset(Constants.Question.offset)
            $0.centerY.equalTo(sanctionField)
            $0.size.equalTo(Constants.Question.size)
        }

        contentView.addSubview(switchButton)
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.edgeInsets.left)
            $0.centerY.equalTo(questionButton)
        }
        
        contentView.addSubview(minLabel)
        minLabel.snp.makeConstraints {
            $0.top.equalTo(sanctionField.snp.bottom).offset(Constants.minInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.minInsets)
        }
        
        questionButton.addTarget(self, action: #selector(questionButtonAction), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskSanctionModel else {
            return
        }
        self.model = model
        
        let coinImageView = UIImageView()
        coinImageView.image = R.image.coinImage()
        let rightModel = FieldAdditionalContentModel(contentView: coinImageView, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.fieldModel, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, rightContent: rightModel)
        
        sanctionField.configure(with: fieldModel)
        sanctionField.updateStyle(model.style)
        switchButton.isOn = model.isEnabled
        switchChanged(switchButton)
        
        minLabel.configure(min: model.minValue)
        minLabel.isHidden = !model.showsMinLabel
        
        model.errorNotification = { [weak self] error in
            self?.sanctionField.bind(error: error)
            self?.bind(error: error)
        }
        
        
    }
    
    @objc
    private func questionButtonAction() {
        model?.questionCallback()
    }
    
    @objc
    private func switchChanged(_ switch: UISwitch) {
        guard let model = model, !model.showsMinLabel else {
            `switch`.isOn = true
            return
        }
        model.setIsEnabled(`switch`.isOn)
        model.switchChanged(`switch`.isOn)
    }
    
}
