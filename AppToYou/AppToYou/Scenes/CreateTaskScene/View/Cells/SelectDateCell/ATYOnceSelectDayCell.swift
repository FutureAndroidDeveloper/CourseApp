//
//  ATYOnceSelectDayCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit


class OnceSelectDayCellModel {
    
}


class ATYOnceSelectDayCell: UITableViewCell, UITextFieldDelegate, InflatableView {

    var datePicker = UIDatePicker()
    
    var startTextField : UITextField = {
        let textField = UITextField()
        textField.text = "21.11.2021"
        textField.leftView?.tintColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.backgroundTextFieldsColor()
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = R.color.textColorSecondary()
        return textField
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
        guard let model = model as? OnceSelectDayCellModel else {
            return
        }
    }

    private func configure() {
        contentView.addSubview(startTextField)

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 44))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.datePickerDone))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        startTextField.inputAccessoryView = toolBar
        startTextField.inputView = datePicker
        startTextField.layer.cornerRadius = 19

        let mailImageView = UIImageView(frame: CGRect(x: 0, y: 2, width: 26, height: 26))
        mailImageView.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        mailImageView.tintColor = R.color.backgroundTextFieldsColor()

        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backView.addSubview(mailImageView)

        startTextField.leftView = backView
        startTextField.delegate = self
        startTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
        startTextField.tintColor = .clear
        startTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(140)
            make.height.equalTo(38)
        }
    }

    @objc func dateChanged() {
        startTextField.text = datePicker.date.toString(dateFormat: .simpleDateFormatFullYear)
    }

    @objc func datePickerDone() {
        startTextField.resignFirstResponder()
    }
}
