import UIKit


class TaskNameCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let texInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: R.string.localizable.taskName())
    private let nameTextField = FieldFactory.shared.getTextField()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.fieldInsets)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskNameModel else {
            return
        }
        
        model.errorNotification = { [weak self] validationError in
            self?.nameTextField.bind(error: validationError)
            self?.bind(error: validationError)
        }
        
        let contentModel = FieldContentModel(fieldModel: model.fieldModel, insets: Constants.texInsets)
        let fieldModel = FieldModel(content: contentModel)
        nameTextField.configure(with: fieldModel)
        
        if model.isActive {
            contentView.enable()
        } else {
            contentView.disable()
        }
    }
    
}
