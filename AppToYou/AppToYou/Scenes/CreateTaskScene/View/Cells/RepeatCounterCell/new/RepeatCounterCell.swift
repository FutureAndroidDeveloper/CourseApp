import UIKit


class RepeatCounterCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let lockInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Количество повторов")
    private let repeatView = RepeatCounterView()
    private let lockButton = ButtonFactory.getLockButton()

    
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }

        contentView.addSubview(repeatView)
        repeatView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.fieldInsets)
        }

        contentView.addSubview(lockButton)
        lockButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.lockInsets)
            $0.centerY.equalTo(repeatView)
        }
        lockButton.isHidden = true
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? RepeatCounterModel else {
            return
        }
        
        if let lockModel = model.lockModel {
            lockButton.configure(with: lockModel)
            lockButton.isHidden = false
        }
        repeatView.configure(model: model.valueModel)
        
        model.errorNotification = { [weak self] error in
            self?.repeatView.bind(error: error)
            self?.bind(error: error)
        }
    }
    
}
