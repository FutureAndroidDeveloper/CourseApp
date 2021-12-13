//
//  ATYCreateTaskNameCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class CreateTaskNameCellModel {
    let nameCallback: ((String) -> Void)
    
    init(nameCallback: @escaping (String) -> Void) {
        self.nameCallback = nameCallback
    }
    
}

class ATYCreateTaskNameCell: UITableViewCell, InflatableView {
    
    func inflate(model: AnyObject) {
        guard let model = model as? CreateTaskNameCellModel else {
            return
        }
        
        callbackText = model.nameCallback
    }
    
    var nameLabel : UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.taskName()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.forExampleDoExercises()
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        return textField
    }()

    var callbackText: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configeureNameLabel()
        configureTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configeureNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func configureTextField() {
        contentView.addSubview(nameTextField)
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        nameTextField.layer.cornerRadius = 22
        nameTextField.delegate = self
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}

extension ATYCreateTaskNameCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callbackText?(textField.text ?? "")
    }
}
