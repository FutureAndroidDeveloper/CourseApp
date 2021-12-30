import UIKit


class CourseTaskMinSanctionCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let descriptionInsets = UIEdgeInsets(top: 7, left: 20, bottom: 0, right: 20)
        static let sanctionInsets = UIEdgeInsets(top: 11, left: 21, bottom: 32, right: 0)
        
        struct Field {
            static let width: CGFloat = 182
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 11)
            static let iconInsets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 11)
        }
        
        static let defaultOpacity: CGFloat = 1
        static let disabledOpacity: CGFloat = 0.6
    }
    
    private var model: CourseTaskMinSanctionModel?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Минимальный штраф*")
    private let sanctionField = FieldFactory.shared.getNaturalNumberField()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "После добавления задачи пользователь может откорректировать величину штрафа. Установите min значение."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 3
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.descriptionInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.descriptionInsets)
        }

        contentView.addSubview(sanctionField)
        sanctionField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.sanctionInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.sanctionInsets)
            $0.width.equalTo(Constants.Field.width)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTaskMinSanctionModel else {
            return
        }
        self.model = model
        
        let coinImageView = UIImageView()
        coinImageView.image = R.image.coinImage()
        let rightModel = FieldAdditionalContentModel(contentView: coinImageView, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.fieldModel, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, rightContent: rightModel)
        
        sanctionField.configure(with: fieldModel)
        
        model.didActivate = { [weak self] isOn in
            self?.changeOpacity(for: isOn)
        }
        
        model.errorNotification = { [weak self] error in
            self?.sanctionField.bind(error: error)
            self?.bind(error: error)
        }
    }
    
    private func changeOpacity(for state: Bool) {
        if state {
            contentView.enable()
        } else {
            contentView.disable()
        }
        model?.updateActiveState(state)
    }
    
}
