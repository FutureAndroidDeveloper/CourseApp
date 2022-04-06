import UIKit


class TaskDidCreateToastView: UIView {
    private struct Constants {
        static let messageTitle = "Задача добавлена"
        static let height: CGFloat = 40
        static let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private let messageLabel = UILabel()

    
    override init(frame: CGRect) {
        let newSize = CGSize(width: frame.width, height: Constants.height)
        let newFrame = CGRect(origin: .zero, size: newSize).inset(by: Constants.insets)
        super.init(frame: newFrame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constants.height / 2
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
    }
    
    private func configure() {
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.center.equalToSuperview()
        }
        messageLabel.textAlignment = .center
        messageLabel.text = Constants.messageTitle
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        backgroundColor = R.color.backgroundTextFieldsColor()
    }
}
