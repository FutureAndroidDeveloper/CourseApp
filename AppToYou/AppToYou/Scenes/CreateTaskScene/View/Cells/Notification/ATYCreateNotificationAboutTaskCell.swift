import UIKit

class ATYCreateNotificationAboutTaskCell: UITableViewCell, InflatableView {
    
    // MARK: - UI
    private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusImage(), for: .normal)
        return button
    }()

    private var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    private var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Напоминание о задаче"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.backgroundColor = R.color.backgroundAppColor()
        return label
    }()

    // MARK: - Properties
    var notificationsViews = [ATYNotificationAboutTaskView]()

    var stackView = UIStackView()

    var callBack: (() -> Void)?
    var plusCallBack: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(switchButton)
        
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        setUp(notificationCount: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inflate(model: AnyObject) {
//        guard let model = model as? CreateNotificationAboutTaskCellModel else {
//            return
//        }
//        
//        callBack = model.callback
    }

    func setUp(notificationCount: Int) {
        notificationsViews.removeAll()
        stackView.removeFromSuperview()
        stackView.removeFullyAllArrangedSubviews()
        for i in 0..<notificationCount {
            let mainView = ATYNotificationAboutTaskView()
            mainView.plusButton.isHidden = i != notificationCount - 1
            mainView.callback = { [weak self] in
                self?.callBack?()
            }
            mainView.plusCallback = { [weak self] in
                self?.plusCallBack?()

            }
            notificationsViews.append(mainView)
        }

        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0


        for view in notificationsViews {
            stackView.addArrangedSubview(view)
        }

        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
