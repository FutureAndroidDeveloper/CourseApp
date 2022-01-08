import UIKit


class TaskDurationCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let lockInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    private var timerCallback: (() -> Void)?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Длительность выполнения задачи")
    private let durationView = TaskDurationView()
    private let lockButton = ButtonFactory.getLockButton()
    
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
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.fieldInsets)
        }
        
        contentView.addSubview(lockButton)
        lockButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.lockInsets)
            $0.centerY.equalTo(durationView)
        }
        lockButton.isHidden = true
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(openTimePicker))
        durationView.addGestureRecognizer(tapRecognizer)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskDurationCellModel else {
            return
        }
        
        if let lockModel = model.lockModel {
            lockButton.configure(with: lockModel)
            lockButton.isHidden = false
        }
        durationView.configure(with: model.durationModel)
        durationView.updateStyle(model.style)
        timerCallback = model.timerCallback
        
        model.errorNotification = { [weak self] error in
            self?.durationView.bind(error: error)
            self?.bind(error: error)
        }
        
        if model.isActive {
            contentView.enable()
        } else {
            contentView.disable()
        }
    }
    
    @objc
    private func openTimePicker() {
        timerCallback?()
    }
    
}
