import UIKit


/**
 Представление ячейки напоминания о задаче.
 */
class NotificationAboutTaskCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let nameInsets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 23)
        static let containerInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 23)
        static let switchOffset: CGFloat = 8
        static let plusOffset: CGFloat = 15
    }
    
    // MARK: - Properties
    private var model: NotificationAboutTaskModel?
    private var editingNotificationView: NotificationTaskTimeView?
    private var switchCallback: ((Bool) -> Void)?
    private var timerCallback: ((TaskNoticationDelegate) -> Void)?
    
    // MARK: - UI
    private let container = UIView()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusImage(), for: .normal)
        return button
    }()

    private let switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Напоминание о задаче"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.backgroundColor = R.color.backgroundAppColor()
        return label
    }()
    
    private let notificationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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
        self.model = model
        switchCallback = model.switchCallback
        timerCallback = model.timerCallback
        configure(model.notificationModels)
    }
    
    private func configure(_ models: [NotificationTaskTimeModel]) {
        notificationStackView.removeFullyAllArrangedSubviews()
        
        models.forEach { [weak self] model in
            let notificationView = NotificationTaskTimeView()
            notificationView.configure(with: model)
            notificationView.addGestureRecognizer(getGestureRecognizer())
            self?.notificationStackView.addArrangedSubview(notificationView)
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
        editingNotificationView = notificationView
        timerCallback?(self)
    }
    
    @objc
    private func plusTapped() {
        // для добавления нового уведомления, не должно быть пустого времени (0; 0)
        guard
            let lastNotificationView = notificationStackView.arrangedSubviews.last as? NotificationTaskTimeView,
            let model = lastNotificationView.model,
            !model.isDefault
        else {
            return
        }

        editingNotificationView = NotificationTaskTimeView()
        timerCallback?(self)
    }
    
    @objc
    private func switchChanged(_ switch: UISwitch) {
        switchCallback?(`switch`.isOn)
    }
    
}


extension NotificationAboutTaskCell: TaskNoticationDelegate {
    func notificationDidAdd(_ notifcation: NotificationTaskTimeModel) {
        guard let editingNotificationView = editingNotificationView else {
            return
        }
        
        // обновление модели
        if let editingModel = editingNotificationView.model {
            editingModel.hourModel.update(value: notifcation.hourModel.value)
            editingModel.minModel.update(value: notifcation.minModel.value)
            editingNotificationView.configure(with: editingModel)
        }
        
        let existingModel = notificationStackView.arrangedSubviews
            .compactMap { $0 as? NotificationTaskTimeView }
            .compactMap { $0.model }
            .first { $0 == notifcation }
        
        // добавление новой модели, если такого времени напоминания еще нет в списке моделей
        if existingModel == nil {
            model?.notificationModels.append(notifcation)
            editingNotificationView.configure(with: notifcation)
            editingNotificationView.addGestureRecognizer(getGestureRecognizer())
            notificationStackView.addArrangedSubview(editingNotificationView)
        }
        
    }
    
    
}
