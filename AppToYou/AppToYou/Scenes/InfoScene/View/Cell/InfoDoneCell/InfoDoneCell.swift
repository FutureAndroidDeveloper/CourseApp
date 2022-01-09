import UIKit




class InfoDoneCell: UITableViewCell, InflatableView {
    private struct Constants {
        static let insets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        static let height: CGFloat = 45
    }
    
    private var model: InfoDoneModel?
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
    }
    
    private func setup() {
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.insets)
            $0.height.equalTo(Constants.height)
        }
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoDoneModel else {
            return
        }
        self.model = model
        doneButton.setTitle(model.title, for: .normal)
    }
    
    @objc
    private func doneAction() {
        model?.action()
    }
    
}
