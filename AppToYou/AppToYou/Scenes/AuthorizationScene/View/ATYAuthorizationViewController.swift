import SnapKit
import UIKit


class ATYAuthorizationViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let loginImageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: -34, right: 20)
        
        static let passwordInsets = UIEdgeInsets(top: -5, left: 20, bottom: 30, right: 20)
        static let emailInsets = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        
        static let loginInstes = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let registrationInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        static let servicesInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        static let continueInsets = UIEdgeInsets(top: 22, left: 20, bottom: 0, right: 20)
        
        struct Email {
            static let textInsets = UIEdgeInsets(top: 12, left: 16, bottom: 13, right: 12)
            static let iconInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 0)
        }
        
        struct Password {
            static let textInsets = UIEdgeInsets(top: 12, left: 16, bottom: 13, right: 100)
            static let iconInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 0)
            static let restoreInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 36)
        }
    }
    
    var viewModel: AuthorizationViewModel!
    
    private let spinner = OverlaySpinner()
    private let emailTextField = FieldFactory.shared.getTextField()
    private var emailContainer = ValidatableViewWrapper()

    private let passwordTextField = FieldFactory.shared.getTextField()
    private var passwordContainer = ValidatableViewWrapper()
    
    private let loginImageView = UIImageView()
    private let titleLabel = LabelFactory.createHeaderLabel(title: R.string.localizable.signIn())
    private let loginButton = ButtonFactory.getStandartButton(title: R.string.localizable.signInAcc())
    private let servicesView = ServiceLoginView()
    private let continueButton = ButtonFactory.getTansparentButton(title: "Продолжить без регистрации")
    
    private lazy var registrationView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.text = R.string.localizable.dontHaveAnAccount()
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = R.color.titleTextColor()
        
        let actionButton = UIButton()
        actionButton.setTitle(R.string.localizable.registerNow(), for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        actionButton.setTitleColor(R.color.buttonColor(), for: .normal)
        actionButton.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, actionButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
    }


    private func configure() {
        let mailContainer = createContainer(for: emailTextField, insets: Constants.emailInsets)
        emailContainer = ValidatableViewWrapper(content: mailContainer)
        view.addSubview(emailContainer)
        emailContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        let passContainer = createContainer(for: passwordTextField, insets: Constants.passwordInsets)
        passwordContainer = ValidatableViewWrapper(content: passContainer)
        view.addSubview(passwordContainer)
        passwordContainer.snp.makeConstraints {
            $0.top.equalTo(mailContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(emailContainer.snp.top).offset(Constants.titleInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        loginImageView.image = R.image.login()
        view.addSubview(loginImageView)
        loginImageView.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top).offset(Constants.loginImageInsets.bottom)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordContainer.snp.bottom).offset(Constants.loginInstes.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.loginInstes)
        }
        
        view.addSubview(registrationView)
        registrationView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Constants.registrationInsets.top)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(servicesView)
        servicesView.snp.makeConstraints {
            $0.top.equalTo(registrationView.snp.bottom).offset(Constants.servicesInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.servicesInsets)
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.top.equalTo(servicesView.snp.bottom).offset(Constants.continueInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.continueInsets)
        }
        
        let forgotButton = UIButton()
        forgotButton.setTitle(R.string.localizable.forgot(), for: .normal)
        forgotButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        forgotButton.setTitleColor(R.color.titleTextColor(), for: .normal)
        
        passContainer.addSubview(forgotButton)
        forgotButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.Password.restoreInsets)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        forgotButton.addTarget(self, action: #selector(forgotButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueFlow), for: .touchUpInside)
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
        let emailContentModel = FieldContentModel(fieldModel: emailModel.fieldModel, insets: Constants.Email.textInsets)
        let mailImageView = UIImageView(image: R.image.mail(), highlightedImage: nil)
        let mailContent = FieldAdditionalContentModel(contentView: mailImageView, insets: Constants.Email.iconInsets)
        let emailFieldModel = FieldModel(content: emailContentModel, leftContent: mailContent)
        
        emailTextField.configure(with: emailFieldModel)
        emailModel.errorNotification = { [weak self] error in
            self?.emailTextField.bind(error: error)
            self?.emailContainer.bind(error: error)
        }
        
        let passwordModel = viewModel.output.passwordModel
        let passwordContentModel = FieldContentModel(fieldModel: passwordModel.fieldModel, insets: Constants.Password.textInsets)
        let passwordImageView = UIImageView(image: R.image.chain(), highlightedImage: nil)
        let passwordContent = FieldAdditionalContentModel(contentView: passwordImageView, insets: Constants.Password.iconInsets)
        let passwordFieldModel = FieldModel(content: passwordContentModel, leftContent: passwordContent)
        
        passwordTextField.configure(with: passwordFieldModel)
        passwordModel.errorNotification = { [weak self] error in
            self?.passwordTextField.bind(error: error)
            self?.passwordContainer.bind(error: error)
        }
        
        servicesView.appleAction = { [weak self] in
            self?.viewModel.input.useAppleAccount()
        }
        
        servicesView.googleAction = { [weak self] in
            self?.viewModel.input.useGoogleAccount()
        }
        
        viewModel.output.isLoading.bind { [weak self] isLoading in
            let spinnerAction: (() -> Void)? = isLoading ? self?.spinner.show : self?.spinner.hide
            spinnerAction?()
        }
    }

    @objc
    private func forgotButtonAction() {
        viewModel.input.resetTapped()
    }
    
    @objc
    private func registrationAction() {
        viewModel.input.registrationTapped()
    }

    @objc
    private func signInButtonAction() {
        viewModel.input.loginTapped()
    }
    
    @objc
    private func continueFlow() {
        viewModel.input.continueFlow()
    }
    
}
