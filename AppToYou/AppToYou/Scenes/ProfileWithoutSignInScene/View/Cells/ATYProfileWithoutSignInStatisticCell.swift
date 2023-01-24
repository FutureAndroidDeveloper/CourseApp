//
//  ATYProfileWithoutSignInStatisticCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYProfileWithoutSignInStatisticCell : UITableViewCell {
    
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
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()

    let statisticView = ATYStatisticProfileView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configire()
        backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configire() {
        contentView.addSubview(signInButton)
        contentView.addSubview(registrationButton)
        contentView.addSubview(statisticView)

        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        signInButton.layer.cornerRadius = 25
        signInButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        registrationButton.layer.cornerRadius = 25
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        statisticView.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    @objc func signInButtonAction() {

    }

    @objc func registrationButtonAction() {

    }
}
