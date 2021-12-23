//
//  View.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import SnapKit

class ATYAuthorizationViewController: UIViewController, BindableType {
    
    var viewModel: AuthorizationViewModel!
    
    
    func bindViewModel() {
        //
    }

    private let inAccountLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.signIn()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.enterYourEmail()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    private let passwordTextField : ATYTextField = {
        let textField = ATYTextField()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.placeholder = R.string.localizable.enterPassword()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.signInAcc(), for: .normal)
        return button
    }()

    private let dontHaveAccountLabel : UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.dontHaveAnAccount()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private let registrationButton : UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.registerNow(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        return button
    }()

    private let forgotButton : UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.forgot(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.addTarget(self, action: #selector(forgotButtonAction), for: .touchUpInside)
        return button
    }()

    private let orLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 13)
        label.text = R.string.localizable.or()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let googleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(googleButtonAction), for: .touchUpInside)
        button.setImage(R.image.google(), for: .normal)
        return button
    }()

    private let fbButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(fbButtonAction), for: .touchUpInside)
        button.setImage(R.image.appleSignInImage(), for: .normal)
        return button
    }()

    private var leftLineView = UIView()
    private var rightLineView = UIView()

    private let dontHaveAccountStackView = UIStackView()
    private let googleOrFacebookStackView = UIStackView()

    //MARK:- Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.backgroundAppColor()
        configureNavBar()
        configureViews()
        configureDontHaveAccountStackView()
        configureOrViews()
        configureGoogleOrFacebookStackView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
    }

    //MARK:- Configure UI


    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }

    private func configureViews() {
        view.addSubview(inAccountLabel)
        inAccountLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }

        let mailImageView = UIImageView(frame: CGRect(x: 0, y: 2, width: 26, height: 26))
        mailImageView.image = R.image.mail()

        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        backView.addSubview(mailImageView)

        view.addSubview(emailTextField)

        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        emailTextField.leftView = backView
        emailTextField.leftViewMode = .always
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(inAccountLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        let chainImageView = UIImageView(frame: CGRect(x: 0, y: 2, width: 26, height: 26))
        chainImageView.image = R.image.chain()

        let backChainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        backChainView.addSubview(chainImageView)

        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 20)
        passwordTextField.leftView = backChainView
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = forgotButton
        passwordTextField.rightViewMode = .always

        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(signInButton)

        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

    private func configureDontHaveAccountStackView() {
        dontHaveAccountStackView.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccountStackView.axis = .horizontal
        dontHaveAccountStackView.alignment = .center
        dontHaveAccountStackView.spacing = 5

        dontHaveAccountStackView.addArrangedSubview(dontHaveAccountLabel)
        dontHaveAccountStackView.addArrangedSubview(registrationButton)

        view.addSubview(dontHaveAccountStackView)

        dontHaveAccountStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(10)
        }
    }

    private func configureOrViews() {
        view.addSubview(leftLineView)
        view.addSubview(orLabel)
        view.addSubview(rightLineView)

        orLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dontHaveAccountStackView.snp.bottom).offset(10)
        }

        leftLineView.backgroundColor = R.color.lineViewBackgroundColor()
        leftLineView.alpha = 0.15
        leftLineView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.trailing.equalTo(orLabel.snp.leading).offset(-5)
            make.centerY.equalTo(orLabel)
            make.height.equalTo(1)
        }

        rightLineView.backgroundColor = R.color.lineViewBackgroundColor()
        rightLineView.alpha = 0.15
        rightLineView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.leading.equalTo(orLabel.snp.trailing).offset(5)
            make.centerY.equalTo(orLabel)
            make.height.equalTo(1)
        }
    }

    private func configureGoogleOrFacebookStackView() {
        googleOrFacebookStackView.translatesAutoresizingMaskIntoConstraints = false
        googleOrFacebookStackView.axis = .horizontal
        googleOrFacebookStackView.alignment = .center
        googleOrFacebookStackView.spacing = 16

        googleOrFacebookStackView.addArrangedSubview(googleButton)
        googleOrFacebookStackView.addArrangedSubview(fbButton)

        view.addSubview(googleOrFacebookStackView)

        googleOrFacebookStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(orLabel.snp.bottom).offset(10)
        }

    }

    //MARK:- Handlers

    @objc func forgotButtonAction() {
        viewModel.input.resetTapped()
    }

    @objc func signInButtonAction() {
//        let login = emailTextField.text ?? String()
        let login = "ecbqfrub75@cashflow35.com"
        let password = "12345678Qq"
//        let password = passwordTextField.text ?? String()
        let credentials = Credentials(mail: login, password: password)
        
        viewModel.input.loginTapped(credentials)
//        viewModel.input.didLogin()
    }

    @objc func registrationButtonAction() {
        viewModel.input.registrationTapped()
    }

    @objc func googleButtonAction() {
        print(DeviceIdentifierService().getDeviceUUID())
        print("registrationButtonAction")
    }

    @objc func fbButtonAction() {
        print("registrationButtonAction")
    }
}
