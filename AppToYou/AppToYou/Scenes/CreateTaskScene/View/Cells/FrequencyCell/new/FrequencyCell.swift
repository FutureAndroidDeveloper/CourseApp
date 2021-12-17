import UIKit


class FrequencyCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
    }

    private let frequencyView = FrequencyView()
    
    private let countingLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.frequencyOfExecution()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(countingLabel)
        countingLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        contentView.addSubview(frequencyView)
        frequencyView.snp.makeConstraints {
            $0.top.equalTo(countingLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.bottom.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? FrequencyModel else {
            return
        }
        
        frequencyView.configure(model: model)
    }
    
}
