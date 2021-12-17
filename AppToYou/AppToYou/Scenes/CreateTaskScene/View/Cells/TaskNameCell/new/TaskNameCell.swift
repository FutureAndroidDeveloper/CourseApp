import UIKit


class TaskNameCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
        static let fieldInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
    }
    
    private let nameTextField = TextField(style: StyleManager.standartTextField)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.taskName()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    
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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TextFieldModel else {
            return
        }
        
        let contentModel = FieldContentModel(fieldModel: model, insets: Constants.fieldInsets)
        let fieldModel = FieldModel(content: contentModel)
        nameTextField.configure(with: fieldModel)
    }
    
}
