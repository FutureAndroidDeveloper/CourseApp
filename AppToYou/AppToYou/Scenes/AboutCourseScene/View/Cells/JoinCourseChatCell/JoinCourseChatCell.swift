import UIKit


class JoinCourseChatCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let buttonTitle = "Войти в чат курса в "
        static let edgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20)
        static let height: CGFloat = 49
    }
    
    private var model: JoinCourseChatModel?
    
    private let joinChatButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        joinChatButton.layer.cornerRadius = joinChatButton.bounds.height / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(joinChatButton)
        joinChatButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.height)
        }
        
        joinChatButton.addTarget(self, action: #selector(joinDidTap), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? JoinCourseChatModel else {
            return
        }
        
        let messanger = model.messanger
        let messangerAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.foregroundColor : R.color.titleTextColor(),
        ]
        let attributedMessanger = NSAttributedString(string: messanger, attributes: messangerAttributes)
        
        let joinText = Constants.buttonTitle
        let joinAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : R.color.titleTextColor(),
        ]
        let attributedJoin = NSAttributedString(string: joinText, attributes: joinAttributes)
        
        let buttonTitle = NSMutableAttributedString()
        buttonTitle.append(attributedJoin)
        buttonTitle.append(attributedMessanger)
        
        
        joinChatButton.setAttributedTitle(buttonTitle, for: .normal)
        joinChatButton.setImage(model.icon, for: .normal)
        self.model = model
    }
    
    @objc
    private func joinDidTap() {
        model?.joinTapped()
    }
    
}
