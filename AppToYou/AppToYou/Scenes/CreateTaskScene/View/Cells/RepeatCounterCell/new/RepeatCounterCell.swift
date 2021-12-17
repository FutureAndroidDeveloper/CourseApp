import UIKit


class RepeatCounterCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
    }
    
    private let repeatView = RepeatCounterView()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Количество повторов"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let lockButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.chain()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = R.color.lineViewBackgroundColor()
        button.isHidden = true
        return button
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
            $0.leading.top.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }

        contentView.addSubview(repeatView)
        repeatView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.bottom)
            $0.leading.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }

//        contentView.addSubview(lockButton)
//        lockButton.addTarget(self, action: #selector(chainButtonAction(_:)), for: .touchUpInside)
//        lockButton.snp.makeConstraints { (make) in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalTo(plusButton)
//            make.height.width.equalTo(24)
//        }
        
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? RepeatCounterModel else {
            return
        }
        
        repeatView.configure(model: model.valueModel)
    }
    
    @objc func chainButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.imageView?.tintColor = sender.isSelected ?  R.color.textColorSecondary() : R.color.lineViewBackgroundColor()
    }
    
}
