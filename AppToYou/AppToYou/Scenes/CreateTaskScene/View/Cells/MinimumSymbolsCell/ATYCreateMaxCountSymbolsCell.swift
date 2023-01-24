//
//  ATYMaxCountSymbolsCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit


class CreateMaxCountSymbolsCellModel {
    
}


class ATYCreateMaxCountSymbolsCell: UITableViewCell, InflatableView {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Минимальное количество символов"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var countOfSymbolsTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .left
        textField.rightViewMode = .always
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    let lockButton : UIButton = {
        let button = UIButton()
        button.setImage(R.image.chain()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = R.color.lineViewBackgroundColor()
        button.isHidden = true
        return button
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

    func inflate(model: AnyObject) {
        guard let model = model as? CreateMaxCountSymbolsCellModel else {
            return
        }
    }
    
    @objc func chainButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.imageView?.tintColor = sender.isSelected ?  R.color.textColorSecondary() : R.color.lineViewBackgroundColor()
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countOfSymbolsTextField)
        contentView.addSubview(lockButton)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        countOfSymbolsTextField.layer.cornerRadius = 22.5
        countOfSymbolsTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0)
        countOfSymbolsTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(45)
            make.bottom.equalToSuperview().offset(-15)
        }

        lockButton.addTarget(self, action: #selector(chainButtonAction(_:)), for: .touchUpInside)
        lockButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(countOfSymbolsTextField)
            make.height.width.equalTo(24)
        }
    }
}
