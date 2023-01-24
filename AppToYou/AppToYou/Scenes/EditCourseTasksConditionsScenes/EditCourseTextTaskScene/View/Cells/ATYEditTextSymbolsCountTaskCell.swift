//
//  ATYEditTextSymbolsCountTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 20.07.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

class ATYEditTextSymbolsCountTaskCell : UITableViewCell {

    let descriptionTaskLabel : UILabel = {
        let label = UILabel()
        label.text = "Суть в том, чтобы замечать приятные мелочи и обращать внимание на них: радоваться тёплой погоде, вкусному ужину и встрече с друзьями, а не только долгожданному отпуску или повышению."
        label.numberOfLines = 0
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let chooseCountSymbolsLabel : UILabel = {
        let label = UILabel()
        label.text = "Выберите оптимальное для вас количество символов для выполнения задачи"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let countSymbolsLabel : UILabel = {
        let label = UILabel()
        label.text = "Количество символов"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()

    var countSymbolsTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundAppColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(descriptionTaskLabel)
        contentView.addSubview(chooseCountSymbolsLabel)
        contentView.addSubview(countSymbolsLabel)
        contentView.addSubview(countSymbolsTextField)

        descriptionTaskLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
        }

        chooseCountSymbolsLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(descriptionTaskLabel.snp.bottom).offset(32)
        }

        countSymbolsLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(countSymbolsLabel.intrinsicContentSize.width)
            make.top.equalTo(chooseCountSymbolsLabel.snp.bottom).offset(16)
        }

        countSymbolsTextField.layer.cornerRadius = 22.5
        countSymbolsTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)

        countSymbolsTextField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(countSymbolsLabel).offset(15)
            make.height.equalTo(45)
            make.top.equalTo(countSymbolsLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
