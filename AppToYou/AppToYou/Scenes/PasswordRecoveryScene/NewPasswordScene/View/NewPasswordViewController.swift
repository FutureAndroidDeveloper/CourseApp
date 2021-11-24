import UIKit


class NewPasswordViewController: UIViewController, BindableType {
    
    var viewModel: NewPasswordViewModelImpl!
    
    func bindViewModel() {
        //
    }
    
    private struct Constants {
        static let descriptionEdgeInsets = UIEdgeInsets(top: 0, left: 33, bottom: 0, right: 33)
    }
    
    let passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.gembokPassword()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let newPasswordLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.newPassword()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let descriptionNewPasswordLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  UIFont.Regular(size: 15)
        label.text = R.string.localizable.newPasswordInstructions()
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let passwordTextField : ATYShowHideTextField = {
        let textField = ATYShowHideTextField()
        textField.placeholder = R.string.localizable.pickAPassword()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()
    
    let repeatPasswordTextField : ATYShowHideTextField = {
        let textField = ATYShowHideTextField()
        textField.placeholder = R.string.localizable.repeatPassword()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let minimumSixLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 13)
        label.text =  R.string.localizable.minimumSix()
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let savePasswordButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(savePasswordButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.savePassword(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        view.backgroundColor = R.color.backgroundAppColor()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
//        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16.0, 0.0, 0.0)
        
        repeatPasswordTextField.layer.cornerRadius = repeatPasswordTextField.frame.height / 2
//        repeatPasswordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16.0, 0.0, 0.0)
        
        savePasswordButton.layer.cornerRadius = savePasswordButton.frame.height / 2
    }


    //MARK: - Configure views

    private func configureViews() {        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        repeatPasswordTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        savePasswordButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        let descriptionContainerView = UIView()
        descriptionContainerView.addSubview(descriptionNewPasswordLabel)
        descriptionNewPasswordLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.descriptionEdgeInsets)
        }
        
        let containerView = UIStackView(arrangedSubviews: [passwordImageView, newPasswordLabel, descriptionContainerView,
                                                           passwordTextField, repeatPasswordTextField, minimumSixLabel,
                                                           savePasswordButton])
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.distribution = .fill
        containerView.setCustomSpacing(37, after: passwordImageView)
        containerView.setCustomSpacing(11, after: newPasswordLabel)
        containerView.setCustomSpacing(40, after: descriptionContainerView)
        containerView.setCustomSpacing(16, after: passwordTextField)
        containerView.setCustomSpacing(8, after: repeatPasswordTextField)
        containerView.setCustomSpacing(24, after: minimumSixLabel)
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    //MARK: - Handlers
    
    @objc func savePasswordButtonAction() {
        let password = passwordTextField.text ?? String()
        let repeatPassword = repeatPasswordTextField.text ?? String()
        
        viewModel.input.savePassword(newPassword: password, repeatPassword: repeatPassword)
    }
    
}
