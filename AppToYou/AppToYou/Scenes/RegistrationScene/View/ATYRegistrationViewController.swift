//
//  ATYRegistrationScene.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYRegistrationViewController: UIViewController, BindableType {
    
    var viewModel: RegistrationViewModel!
    
    
    func bindViewModel() {
        //
    }

    let registrationLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.registerNow()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.enterYourEmail()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let passwordTextField : ATYShowHideTextField = {
        let textField = ATYShowHideTextField()
        textField.placeholder = R.string.localizable.pickAPassword()
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

    let doneButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.register(), for: .normal)
        return button
    }()

    private let userAgreementInfoTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupUserAgreementInfoLabel()
        view.backgroundColor = R.color.backgroundAppColor()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }


    //MARK:- Configure views

    private func configureViews() {
        view.addSubview(registrationLabel)
        registrationLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(emailTextField)
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(registrationLabel.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(passwordTextField)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(minimumSixLabel)
        minimumSixLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(minimumSixLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
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

        self.view.addSubview(self.userAgreementInfoTextView)
        self.userAgreementInfoTextView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.doneButton.snp.bottom).offset(20)
            make.height.equalTo(65)
            make.width.equalTo(UIScreen.main.bounds.width-70)
        }
    }

    //MARK:- Handlers
    
    @objc func doneButtonAction() {
        let mail = emailTextField.text ?? String()
        let pass = passwordTextField.text ?? String()
        
        viewModel.input.credentialsEntered(mail: mail, password: pass)
//        let nameVc = ATYEnterNameViewController()
//        navigationController?.pushViewController(nameVc, animated: true)
    }
}

extension ATYRegistrationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        viewModel.input.open(url: URL)
        return false
    }
}
