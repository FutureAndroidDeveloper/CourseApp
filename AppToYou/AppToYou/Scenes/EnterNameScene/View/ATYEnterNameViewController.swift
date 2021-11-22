//
//  ATYEnterNameViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEnterNameViewController: UIViewController, BindableType {
    
    var viewModel: EnterNameViewModel!
    
    func bindViewModel() {
        //
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.letSGetAcquainted()
        label.numberOfLines = 2
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.myNameIs()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let doneButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.completeRegistration(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureViews()
        configureNavBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }

    //MARK:- Configure views

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func configureViews() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }

        view.addSubview(nameTextField)
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

    }

    //MARK:- Handlers

    @objc func doneButtonAction() {
        let name = nameLabel.text ?? String()
        viewModel.input.nameEntered(name: name)
    }
    
}
