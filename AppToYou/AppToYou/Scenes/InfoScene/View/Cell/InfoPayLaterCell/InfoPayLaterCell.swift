import UIKit


class InfoPayLaterCell: UITableViewCell, InflatableView {
    private struct Constants {
        static let insets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        static let height: CGFloat = 45
    }
    
    private var model: InfoPayLaterModel?
    
    private let payLatterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оплачу позже", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        return button
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
        contentView.addSubview(payLatterButton)
        payLatterButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.insets)
            $0.height.equalTo(Constants.height)
        }
        payLatterButton.addTarget(self, action: #selector(payLatterAction), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoPayLaterModel else {
            return
        }
        self.model = model
    }
    
    @objc
    private func payLatterAction() {
        model?.action()
    }
    
}
