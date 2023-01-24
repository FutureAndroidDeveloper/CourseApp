//
//  ATYCreateDurationTaskCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 31.05.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit


class CreateDurationTaskCellModel {
    
}


class ATYCreateDurationTaskCell: UITableViewCell, InflatableView {

    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Длительность выполнения задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var hourTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + R.string.localizable.hour()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var minTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + R.string.localizable.min()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var secTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "0 " + R.string.localizable.sec()
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
        guard let model = model as? ATYCreateDurationTaskCell else {
            return
        }
    }
    
    @objc func chainButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.imageView?.tintColor = sender.isSelected ?  R.color.textColorSecondary() : R.color.lineViewBackgroundColor()
    }

    private func configure() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(hourTextField)
        contentView.addSubview(minTextField)
        contentView.addSubview(secTextField)
        contentView.addSubview(lockButton)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        hourTextField.layer.cornerRadius = 22.5
        hourTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        hourTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalTo(85)
            make.bottom.equalToSuperview().offset(-15)
        }

        minTextField.layer.cornerRadius = 22.5
        minTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        minTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(hourTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        secTextField.layer.cornerRadius = 22.5
        secTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        secTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalTo(minTextField.snp.trailing).offset(12)
            make.height.equalTo(45)
            make.width.equalTo(85)
        }

        lockButton.addTarget(self, action: #selector(chainButtonAction(_:)), for: .touchUpInside)
        lockButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(secTextField)
            make.height.width.equalTo(24)
        }
    }
}
