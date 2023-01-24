//
//  ATYProfileSignInButtonsCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYProfileSignInButtonsCell : UITableViewCell {

    private let takeVacationButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Взять отпуск", for: .normal)
        return button
    }()

    private let logOutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.setTitleColor(R.color.buttonColor(), for: .normal)
        button.setTitle("Выйти из аккаунта  ", for: .normal)
        return button
    }()

    var logOutCallback : (() -> ())?
    var takeVacationCallback : (() -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configire()
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configire() {
        contentView.addSubview(takeVacationButton)
        contentView.addSubview(logOutButton)

        takeVacationButton.addTarget(self, action: #selector(takeVacationAction), for: .touchUpInside)
        takeVacationButton.layer.cornerRadius = 25
        takeVacationButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        logOutButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        logOutButton.setImage(R.image.logOutImage(), for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        logOutButton.layer.cornerRadius = 25
        logOutButton.snp.makeConstraints { (make) in
            make.top.equalTo(takeVacationButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    @objc func takeVacationAction() {
        takeVacationCallback?()
    }

    @objc func logOutAction() {
        logOutCallback?()
    }
}
