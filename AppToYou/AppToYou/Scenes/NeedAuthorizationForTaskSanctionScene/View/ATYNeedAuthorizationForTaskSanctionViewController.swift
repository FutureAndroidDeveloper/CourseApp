//
//  ATYNeedAuthorizationForTaskSanctionViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 05.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYNeedAuthorizationForTaskSanctionViewController: UIViewController {
    //     self.transitionThird = PanelTransition(y: view.bounds.height * 0.65 , height: view.bounds.height * 0.35)]
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Для создания задачи со штрафом необходимо авторизироваться"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 0
        return label
    }()

    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Войти", for: .normal)
        return button
    }()

    private let registrationButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()

    let lineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLineView()
        configure()

        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureLineView() {
        view.addSubview(lineView)
        lineView.backgroundColor = R.color.lightGrayColor()
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
    }

    private func configure() {
        view.addSubview(label)
        view.addSubview(signInButton)
        view.addSubview(registrationButton)

        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(lineView.snp.bottom).offset(21)
        }

        registrationButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }

        signInButton.layer.cornerRadius = 25
        signInButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(registrationButton.snp.top).offset(-15)
            make.height.equalTo(50)
        }
    }
}
