import UIKit


class DescriptionTaskCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        
        struct Field {
            static let hight: CGFloat = 125
        }
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Описание задачи")
    private let descriptionTextView = PlaceholderTextView()
    

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

        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.fieldInsets)
            $0.height.equalTo(Constants.Field.hight)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? DescriptionModel else {
            return
        }
        
        descriptionTextView.configure(with: model.fieldModel)
        model.errorNotification = { [weak self] error in
            self?.descriptionTextView.bind(error: error)
            self?.bind(error: error)
        }
        
        if model.isEditable {
            contentView.enable()
        } else {
            contentView.disable()
        }
    }
    
}
