//
//  ATYEditCourseCountTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 16.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYEditCourseCountTaskCell: UITableViewCell {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Количество повторов"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var repeatTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    private let minusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.minusButtonImage(), for: .normal)
        return button
    }()

    private let plusButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButtonImage(), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(repeatTextField)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        repeatTextField.layer.cornerRadius = 22.5
        repeatTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        repeatTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-15)
        }

        minusButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(repeatTextField)
            make.leading.equalTo(repeatTextField.snp.trailing).offset(12)
            make.height.width.equalTo(20)
        }

        plusButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(repeatTextField)
            make.leading.equalTo(minusButton.snp.trailing).offset(12)
            make.height.width.equalTo(20)
        }
    }
}
