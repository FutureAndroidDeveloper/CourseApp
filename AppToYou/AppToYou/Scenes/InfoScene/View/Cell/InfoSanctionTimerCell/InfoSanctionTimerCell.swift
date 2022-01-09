import UIKit


class InfoSanctionTimerCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let insets = UIEdgeInsets(top: 42, left: 0, bottom: 15, right: 0)
    }
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .medium)
        label.textColor = R.color.textColorSecondary()
        label.textAlignment = .center
        return label
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
        contentView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.insets)
            $0.center.equalToSuperview()
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoSanctionTimerModel else {
            return
        }
        
        model.timerChanged = { [weak self] timer in
            self?.timerLabel.text = timer
        }
    }
    
}
