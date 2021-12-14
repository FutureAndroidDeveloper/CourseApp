import UIKit


class DescriptionTaskCell: UITableViewCell, InflatableView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let descriptionTextView = PlaceholderTextView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? PlaceholderTextViewModel else {
            return
        }
        
        descriptionTextView.configure(with: model)
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(125)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
}
