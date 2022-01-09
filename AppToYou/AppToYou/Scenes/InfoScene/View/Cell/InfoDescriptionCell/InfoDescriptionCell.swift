import UIKit
import SnapKit


class InfoDescriptionCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let centerInsets = UIEdgeInsets(top: 15, left: 35, bottom: 24, right: 35)
        static let leftInsets = UIEdgeInsets(top: 32, left: 20, bottom: 32, right: 20)
    }
    
    private let descriptionLabel = LabelFactory.getAddTaskDescriptionLabel(title: nil)
    private var edgeConstraints: Constraint?
    
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
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { [weak self] in
            self?.edgeConstraints = $0.edges.equalToSuperview().constraint
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        descriptionLabel.numberOfLines = 0
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoDescriptionModel else {
            return
        }
        descriptionLabel.text = model.text
        updateLayout(for: model.notificationType)
    }
    
    
    private func updateLayout(for notification: UserInfoNotification) {
        switch notification {
        case .courseTaskAdded, .allCourseTasksAdded:
            descriptionLabel.textAlignment = .left
            edgeConstraints?.update(inset: Constants.leftInsets)
            
        case .failureSanction, .paySanction:
            descriptionLabel.textAlignment = .center
            edgeConstraints?.update(inset: Constants.centerInsets)
        }
    }
    
}
