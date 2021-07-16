//
//  ATYCreateCourseTaskMinSanction.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateCourseTaskMinSanctionCell: UITableViewCell {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Минимальный штраф*"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "После добавления задачи пользователь может\nоткорректировать величину штрафа.\nУстановите min значение."
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    var sanctionTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(sanctionTextField)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }

        let coinImageView = UIImageView(frame: CGRect(x: 0, y: 4.5, width: 21, height: 21))
        coinImageView.image = R.image.coinImage()

        let coinView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
        coinView.addSubview(coinImageView)

        self.sanctionTextField.rightView = coinView
        self.sanctionTextField.rightViewMode = .always

        sanctionTextField.layer.cornerRadius = 22.5
        sanctionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        sanctionTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
