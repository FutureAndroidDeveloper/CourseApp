import UIKit


class MinimumSymbolsCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
        
        struct Field {
            static let size = CGSize(width: 182, height: 45)
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
        }
    }
    
    private let countOfSymbolsTextField = NaturalNumberTextField(style: StyleManager.standartTextField)

    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Минимальное количество символов"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

//    let lockButton : UIButton = {
//        let button = UIButton()
//        button.setImage(R.image.chain()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        button.imageView?.tintColor = R.color.lineViewBackgroundColor()
//        button.isHidden = true
//        return button
//    }()

    
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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }

        contentView.addSubview(countOfSymbolsTextField)
        countOfSymbolsTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.bottom)
            $0.leading.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.size.equalTo(Constants.Field.size)
        }

//        contentView.addSubview(lockButton)
//        lockButton.addTarget(self, action: #selector(chainButtonAction(_:)), for: .touchUpInside)
//        lockButton.snp.makeConstraints { (make) in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalTo(countOfSymbolsTextField)
//            make.height.width.equalTo(24)
//        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? NaturalNumberFieldModel else {
            return
        }
        
        let contentModel = FieldContentModel(fieldModel: model, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel)
        countOfSymbolsTextField.configure(with: fieldModel)
    }
    
//    @objc
//    private func chainButtonAction(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        sender.imageView?.tintColor = sender.isSelected ?  R.color.textColorSecondary() : R.color.lineViewBackgroundColor()
//    }
    
}