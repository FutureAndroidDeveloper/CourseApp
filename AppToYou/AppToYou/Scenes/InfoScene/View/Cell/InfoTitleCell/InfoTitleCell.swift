import UIKit
import SnapKit


class InfoTitleCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let centerInsets = UIEdgeInsets(top: 0, left: 60, bottom: 21, right: 60)
        static let leftInsets = UIEdgeInsets(top: 0, left: 20, bottom: 21, right: 20)
        
        struct Icon {
            static let spacing: CGFloat = 8
            static let size = CGSize(width: 32, height: 32)
        }
    }
    
    private let titleLabel = LabelFactory.getAddTaskTitleLabel(title: nil)
    private let iconImageView = UIImageView()
    private var edgeConstraints: Constraint?
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, iconImageView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = Constants.Icon.spacing
        return stack
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundAppColor()
        return view
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
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints { [weak self] in
            self?.edgeConstraints = $0.edges.equalToSuperview().constraint
        }
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.Icon.size)
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        titleLabel.numberOfLines = 0
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoTitleModel else {
            return
        }
        
        if let icon = model.icon {
            iconImageView.image = icon
        } else {
            iconImageView.isHidden = true
        }
        titleLabel.text = model.title
        updateLayout(for: model.notificationType)
    }
    
    
    private func updateLayout(for notification: UserInfoNotification) {
        switch notification {
        case .courseTaskAdded, .allCourseTasksAdded:
            titleLabel.textAlignment = .left
            edgeConstraints?.update(inset: Constants.leftInsets)
            
        case .failureSanction, .paySanction:
            titleLabel.textAlignment = .center
            edgeConstraints?.update(inset: Constants.centerInsets)
        }
    }
    
}
