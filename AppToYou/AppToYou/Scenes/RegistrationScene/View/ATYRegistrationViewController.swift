import UIKit


class ATYRegistrationViewController: UIViewController, UITextViewDelegate, BindableType {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: -49, right: 20)
        
        static let passwordInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let passwordHintInsets = UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)
        
        static let passwordContainerInsets = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        
        static let emailInsets = UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 20)
        
        static let registerInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        static let agreementInsets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        static let agreementHeight: CGFloat = 48
        static let accountInstes = UIEdgeInsets(top: 31, left: 0, bottom: 0, right: 0)
        static let servicesInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        
        struct Email {
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 10)
        }
        
        struct Password {
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 10)
            static let iconInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 16)
        }
    }
    
    var viewModel: RegistrationViewModel!

    private let emailTextField = FieldFactory.shared.getTextField()
    private var emailContainer = ValidatableViewWrapper()

    private let passwordTextField = HidePasswordTextField()
    private var passwordContainer = ValidatableViewWrapper()
    
    private let titleLabel = LabelFactory.createHeaderLabel(title: R.string.localizable.registerNow())
    private let passwordHintLabel = LabelFactory.getChooseTaskDescriptionLable(title: R.string.localizable.minimumSix())
    private let registerButton = ButtonFactory.getStandartButton(title: R.string.localizable.register())
    private let userAgreementInfoTextView = UITextView()
    private let servicesView = ServiceLoginView()
    
    private lazy var accountView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.text = "Есть аккаунт?"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = R.color.titleTextColor()
        
        let actionButton = UIButton()
        actionButton.setTitle("Войти", for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        actionButton.setTitleColor(R.color.buttonColor(), for: .normal)
        actionButton.addTarget(self, action: #selector(accountAction), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, actionButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.backgroundAppColor()
        configureViews()
        setupUserAgreementInfoLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerButton.layer.cornerRadius = registerButton.bounds.height / 2
    }

    private func configureViews() {
        let passwordView = UIView()
        passwordView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.passwordInsets)
        }
        passwordView.addSubview(passwordHintLabel)
        passwordHintLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Constants.passwordHintInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.passwordHintInsets)
        }
        
        let passContainer = createContainer(for: passwordView, insets: Constants.passwordContainerInsets)
        passwordContainer = ValidatableViewWrapper(content: passContainer)
        view.addSubview(passwordContainer)
        passwordContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        let mailContainer = createContainer(for: emailTextField, insets: Constants.emailInsets)
        emailContainer = ValidatableViewWrapper(content: mailContainer)
        view.addSubview(emailContainer)
        emailContainer.snp.makeConstraints {
            $0.bottom.equalTo(passwordContainer.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(emailContainer.snp.top).offset(Constants.titleInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.registerInsets)
        }
        
        view.addSubview(userAgreementInfoTextView)
        userAgreementInfoTextView.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(Constants.agreementInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.agreementInsets)
            $0.height.equalTo(Constants.agreementHeight)
        }
        
        view.addSubview(accountView)
        accountView.snp.makeConstraints {
            $0.top.equalTo(userAgreementInfoTextView.snp.bottom).offset(Constants.accountInstes.top)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(servicesView)
        servicesView.snp.makeConstraints {
            $0.top.equalTo(accountView.snp.bottom).offset(Constants.servicesInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.servicesInsets)
        }
        
        registerButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
    }
    
    private func createContainer(for view: UIView, insets: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
        return container
    }
    
    func bindViewModel() {
        let emailModel = viewModel.output.emailModel
        let contentModel = FieldContentModel(fieldModel: emailModel.fieldModel, insets: Constants.Email.textInsets)
        emailTextField.configure(with: FieldModel(content: contentModel))
        emailModel.errorNotification = { [weak self] error in
            self?.emailTextField.bind(error: error)
            self?.emailContainer.bind(error: error)
        }
        
        let passwordModel = viewModel.output.passwordModel
        passwordTextField.configure(with: passwordModel.fieldModel)
        passwordModel.errorNotification = { [weak self] error in
            self?.passwordTextField.bind(error: error)
            self?.passwordContainer.bind(error: error)
        }
        
        servicesView.appleAction = { [weak self] in
            self?.viewModel.input.createAppleAccount()
        }
        
        servicesView.googleAction = { [weak self] in
            self?.viewModel.input.createGoogleAccount()
        }
    }

    private func setupUserAgreementInfoLabel() {
        let byAcceptingString = NSMutableAttributedString(string: R.string.localizable.byClicking(), attributes: nil)
        let byAcceptingStringTwo = NSMutableAttributedString(string: R.string.localizable.appWith(), attributes: nil)
        let spaceString = NSMutableAttributedString(string: " ", attributes: nil)
        let linkString = R.string.localizable.termsOfUse()
        let linkToPolicy = NSMutableAttributedString(string: linkString, attributes:[NSAttributedString.Key.link: URL(string: "https://spinner.money/privacy.html")!])
        let linkToAgreement = NSMutableAttributedString(string: R.string.localizable.privacyPolicy(), attributes:[NSAttributedString.Key.link: URL(string: "https://spinner.money/terms.html")!])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(byAcceptingString)
        fullAttributedString.append(spaceString)
        fullAttributedString.append(linkToPolicy)
        fullAttributedString.append(spaceString)
        fullAttributedString.append(byAcceptingStringTwo)
        fullAttributedString.append(spaceString)
        fullAttributedString.append(linkToAgreement)

        self.userAgreementInfoTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.buttonColor() ?? .orange]
        self.userAgreementInfoTextView.backgroundColor = R.color.backgroundAppColor()
        self.userAgreementInfoTextView.delegate = self
        self.userAgreementInfoTextView.font = UIFont(name: "Halvetica", size: 17)
        self.userAgreementInfoTextView.font = UIFont.systemFont(ofSize: 14)
        self.userAgreementInfoTextView.attributedText = fullAttributedString
        self.userAgreementInfoTextView.centerVerticalText()
        self.userAgreementInfoTextView.textColor = R.color.textSecondaryColor()
        self.userAgreementInfoTextView.isEditable = false
    }

    @objc
    private func doneButtonAction() {
        viewModel.input.register()
    }
    
    @objc
    private func accountAction() {
        viewModel.input.back()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        viewModel.input.open(url: URL)
        return false
    }
    
}
