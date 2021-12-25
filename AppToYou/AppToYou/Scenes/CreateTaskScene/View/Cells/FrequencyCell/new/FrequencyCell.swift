import UIKit
import SnapKit


class FrequencyCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let edgeInsets = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 20)
        
        static let defaultBottomInset: CGFloat = 32
        static let pickerBottomInset: CGFloat = 10
    }

    private var bottomConstraint: Constraint?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: R.string.localizable.frequencyOfExecution())
    private let frequencyView = FrequencyView()
    

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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(frequencyView)
        frequencyView.snp.makeConstraints { [weak self] in
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
            self?.bottomConstraint = $0.bottom.equalToSuperview().constraint
        }
        
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? FrequencyModel else {
            return
        }
        
        frequencyView.configure(model: model) { [weak self] frequency in
            switch frequency {
            case .ONCE, .CERTAIN_DAYS:
                self?.bottomConstraint?.update(inset: Constants.pickerBottomInset)
            default:
                self?.bottomConstraint?.update(inset: Constants.defaultBottomInset)
            }
        }
    }
    
}
