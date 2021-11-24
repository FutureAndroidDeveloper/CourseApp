//
//  ATYForgotPasswordViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYForgotPasswordViewController: UIViewController, BindableType {
    
    var viewModel: ForgotPasswordViewModel!
    
    func bindViewModel() {
        //
    }
    
    let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.email()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let enterEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.enterEmail()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let descriptionEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  UIFont.Regular(size: 15)
        label.text = R.string.localizable.weWiilSendYourInstructions()
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let emailTextField : UITextField = {
        let textField = PaddingTextField()
        textField.placeholder = R.string.localizable.enterEmail()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let doneButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.restorePassword(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureViews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }


    //MARK: - Configure views

    private func configureViews() {
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        doneButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        let containerView = UIStackView(arrangedSubviews: [emailImageView, enterEmailLabel, descriptionEmailLabel,
                                                           emailTextField, doneButton])
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.distribution = .fill
        containerView.setCustomSpacing(25, after: emailImageView)
        containerView.setCustomSpacing(11, after: enterEmailLabel)
        containerView.setCustomSpacing(52, after: descriptionEmailLabel)
        containerView.setCustomSpacing(24, after: emailTextField)
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    //MARK:- Handlers

    @objc func doneButtonAction() {
        let email = emailTextField.text ?? String()
        viewModel.input.resetPaasword(for: email)
    }
    
}
