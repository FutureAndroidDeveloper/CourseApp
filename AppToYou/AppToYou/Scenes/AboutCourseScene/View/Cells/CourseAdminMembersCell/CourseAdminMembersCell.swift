import UIKit


class CourseAdminMembersCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20)
        static let height: CGFloat = 49
        static let notificationInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
    }
    
    private var model: CourseAdminMembersModel?
    
    private let membersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Участники курса", for: .normal)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(R.image.addMemberimage(), for: .normal)
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        let direction = UIApplication.shared.userInterfaceLayoutDirection
        button.semanticContentAttribute = direction == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return button
    }()
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = R.color.textColorSecondary()
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        membersButton.layer.cornerRadius = membersButton.bounds.height / 2
    }

    private func setup() {
        contentView.addSubview(membersButton)
        membersButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.height)
        }
        
//        membersButton.addSubview(notificationsLabel)
//        notificationsLabel.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(Constants.notificationInsets)
//            $0.centerY.equalToSuperview()
//        }
        
        contentView.addSubview(notificationsLabel)
        notificationsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.notificationInsets)
            $0.centerY.equalTo(membersButton)
        }
        
        membersButton.addTarget(self, action: #selector(membersDidTap), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseAdminMembersModel else {
            return
        }
        self.model = model
        notificationsLabel.text = "(+\(model.newNotifications))"
    }
    
    @objc
    private func membersDidTap() {
        model?.membersTapped()
    }
    
}
