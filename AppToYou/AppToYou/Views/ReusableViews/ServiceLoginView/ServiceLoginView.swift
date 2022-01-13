import UIKit


class ServiceLoginView: UIView {
    
    private struct Constants {
        static let servicesInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 0)
        static let separatorSize = CGSize(width: 88, height: 1)
    }
    
    var googleAction: (() -> Void)?
    var appleAction: (() -> Void)?
    
    private let separatorLabel = LabelFactory.getChooseTaskDescriptionLable(title: R.string.localizable.or())
    
    private lazy var separatorStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getSeparatorView(), separatorLabel, getSeparatorView()])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 13
        return stack
    }()
    
    private let googleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(googleDidtap), for: .touchUpInside)
        button.setImage(R.image.google(), for: .normal)
        return button
    }()

    private let appleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(appleDidtap), for: .touchUpInside)
        button.setImage(R.image.appleSignInImage(), for: .normal)
        return button
    }()
    
    private lazy var servicesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [googleButton, appleButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        separatorLabel.textColor = UIColor.gray
        separatorLabel.numberOfLines = 1
        
        addSubview(separatorStackView)
        separatorStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        addSubview(servicesStackView)
        servicesStackView.snp.makeConstraints {
            $0.top.equalTo(separatorStackView.snp.bottom).offset(Constants.servicesInsets.top)
            $0.bottom.equalToSuperview().inset(Constants.servicesInsets)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func getSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = R.color.lineViewBackgroundColor()
        view.snp.makeConstraints {
            $0.size.equalTo(Constants.separatorSize)
        }
        view.layer.opacity = 0.15
        return view
    }

    @objc
    private func googleDidtap() {
        googleAction?()
    }
    
    @objc
    private func appleDidtap() {
        appleAction?()
    }
    
}
