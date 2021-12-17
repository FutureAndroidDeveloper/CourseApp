import UIKit


class DescriptionTaskCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
        
        struct Field {
            static let hight: CGFloat = 125
        }
    }
    
    private let descriptionTextView = PlaceholderTextView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()


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
            $0.top.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }

        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.Field.hight)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? PlaceholderTextViewModel else {
            return
        }
        
        descriptionTextView.configure(with: model)
    }
    
}
