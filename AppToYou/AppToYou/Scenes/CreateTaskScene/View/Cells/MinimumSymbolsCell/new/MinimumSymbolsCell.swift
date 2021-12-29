import UIKit


class MinimumSymbolsCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleinsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let lockInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        struct Field {
            static let width: CGFloat = 182
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
        }
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Минимальное количество символов")
    private let countOfSymbolsTextField = FieldFactory.shared.getNaturalNumberField()
    private let lockButton = ButtonFactory.getLockButton()

    
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
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleinsets)
        }

        contentView.addSubview(countOfSymbolsTextField)
        countOfSymbolsTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.fieldInsets)
            $0.width.equalTo(Constants.Field.width)
        }

        contentView.addSubview(lockButton)
        lockButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.lockInsets)
            $0.centerY.equalTo(countOfSymbolsTextField)
        }
        lockButton.isHidden = true
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? MinimumSymbolsModel else {
            return
        }
        
        if let lockModel = model.lockModel {
            lockButton.configure(with: lockModel)
            lockButton.isHidden = false
        }
        
        let contentModel = FieldContentModel(fieldModel: model.fieldModel, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel)
        countOfSymbolsTextField.configure(with: fieldModel)
        
        model.errorNotification = { [weak self] error in
            self?.countOfSymbolsTextField.bind(error: error)
            self?.bind(error: error)
        }
    }
    
}
