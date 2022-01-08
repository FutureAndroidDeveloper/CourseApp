import UIKit


/**
 Представление ячейки напоминания о задаче.
 */
class NotificationAboutTaskCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let containerInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let switchOffset: CGFloat = 8
        
        struct Plus {
            static let offset: CGFloat = 15
            static let size = CGSize(width: 20, height: 20)
        }
    }
    
    // MARK: - Properties
    private var model: NotificationAboutTaskModel?
    private var editingNotificationView: NotificationTaskTimeView?
    private var timerCallback: ((TaskNoticationDelegate) -> Void)?
    
    // MARK: - UI
    private let container = UIView()
    private let titleLabel = LabelFactory.getTitleLabel(title: "Напоминание о задаче")
    
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
    
    private let notificationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.containerInsets.top)
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
            $0.size.equalTo(Constants.Plus.size)
            $0.leading.equalTo(notificationStackView.snp.trailing).offset(Constants.Plus.offset)
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
        timerCallback = model.timerCallback
        configure(model.notificationModels)
        switchButton.isOn = model.isEnabled
        
        model.errorNotification = { [weak self] error in
            self?.bind(error: error)
        }
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
        model?.setIsEnabled(`switch`.isOn)
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
            model?.add(notification: notifcation)
            editingNotificationView.configure(with: notifcation)
            editingNotificationView.addGestureRecognizer(getGestureRecognizer())
            notificationStackView.addArrangedSubview(editingNotificationView)
        }
        
    }
    
}
