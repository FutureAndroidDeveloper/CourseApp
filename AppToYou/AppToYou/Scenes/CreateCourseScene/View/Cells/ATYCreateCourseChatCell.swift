//
//  ATYCreateCourseChatCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 08.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateCourseChatCell: UITableViewCell {
    
    let chatLabel : UILabel = {
        let label = UILabel()
        label.text = "Чат курса"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let descriptionChatLabel : UILabel = {
        let label = UILabel()
        label.text = "Вы можете в любой момент\nзакрыть чат своего курса"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 2
        return label
    }()

    var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(chatLabel)
        contentView.addSubview(descriptionChatLabel)
        contentView.addSubview(switchButton)

        chatLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionChatLabel.snp.makeConstraints { (make) in
            make.top.equalTo(chatLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }

        switchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(chatLabel)
        }
    }
}
