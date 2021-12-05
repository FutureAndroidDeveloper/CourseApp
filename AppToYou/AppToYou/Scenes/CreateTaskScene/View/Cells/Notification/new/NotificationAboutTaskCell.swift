import UIKit


/**
 Представление ячейки напоминания о задаче.
 */
class NotificationAboutTaskCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let nameInsets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        static let containerInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 32)
        static let switchOffset: CGFloat = 8
        static let plusOffset: CGFloat = 15
    }
    
    // MARK: - UI
    
    private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusImage(), for: .normal)
        return button
    }()

    private var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
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
    
    private var notificationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private let container = UIView()
    
    // MARK: - Properties
    
    private var notificationViews = [NotificationTaskTimeView]()
    private var switchCallback: ((Bool) -> Void)?
    private var timerCallback: ((NotificationTaskTimeView) -> Void)?

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
            $0.top.leading.trailing.equalToSuperview().inset(Constants.nameInsets)
        }
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.containerInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.containerInsets)
        }
        
        container.addSubview(switchButton)
        switchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.switchOffset)
            $0.trailing.equalToSuperview()
        }
        
        container.addSubview(notificationStackView)
        notificationStackView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        container.addSubview(plusButton)
        plusButton.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.leading.equalTo(notificationStackView.snp.trailing).offset(Constants.plusOffset)
            $0.centerY.equalTo(switchButton.snp.centerY)
            $0.trailing.lessThanOrEqualTo(switchButton.snp.leading)
        }
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? NotificationAboutTaskModel else {
            return
        }
        
        switchCallback = model.switchCallback
        timerCallback = model.timerCallback
        configure(model.notificationModels)
    }
    
    private func configure(_ models: [NotificationTaskTimeModel]) {
        notificationViews.removeAll()
        notificationStackView.removeFullyAllArrangedSubviews()
        
        notificationViews = models.map { model -> NotificationTaskTimeView in
            let notificationView = NotificationTaskTimeView()
            notificationView.configure(with: model)
            return notificationView
        }
        
        for view in notificationViews {
            view.addGestureRecognizer(getGestureRecognizer())
            notificationStackView.addArrangedSubview(view)
        }
    }
    
    private func getGestureRecognizer() -> UITapGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(handleTap(_:)))
        return tapRecognizer
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let notificationView = sender.view as? NotificationTaskTimeView else {
            return
        }
        timerCallback?(notificationView)
    }
    
    @objc
    private func plusTapped() {
        // для добавления нового уведомления, не должно быть пустого времени (0; 0)
        guard
            let lastModel = notificationViews.last?.model,
            !lastModel.isDefault
        else {
            return
        }
        
        let newNotification = NotificationTaskTimeView()
        newNotification.addGestureRecognizer(getGestureRecognizer())
        notificationStackView.addArrangedSubview(newNotification)
        
        timerCallback?(newNotification)
    }
    
    @objc
    private func switchChanged(_ switch: UISwitch) {
        switchCallback?(`switch`.isOn)
    }
    
}


