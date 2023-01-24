//
//  File.swift
//  AppToYou
//
//  Created by Philip Bratov on 02.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit


class SelectWeekDaysCellModel {
    let callbackResult: ((String) -> Void)
    
    init(callbackResult: @escaping (String) -> Void) {
        self.callbackResult = callbackResult
    }
    
}


class ATYSelectWeekDaysCell: UITableViewCell, UITextFieldDelegate, InflatableView {

    private var weekDaysButton = [ATYWeekDaysButton]()
    private let stackViewButtons = UIStackView()
    private let titlesForButton = ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"]
    private var resultString = ""
    
    private var callbackResult: ((String) -> Void)?

    var datePicker = UIDatePicker()

    var startLabel : UILabel = {
        let label = UILabel()
        label.text = "Начало выполнения"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var endLabel : UILabel = {
        let label = UILabel()
        label.text = "Конец выполнения"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    var startTextField : UITextField = {
        let textField = UITextField()
        textField.text = "21.11.2021"
        textField.leftView?.tintColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        return textField
    }()

    var endTextField : UITextField = {
        let textField = UITextField()
        textField.text = "21.11.2021"
        textField.leftView?.tintColor = R.color.backgroundTextFieldsColor()
        textField.textColor = R.color.titleTextColor()
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = R.color.backgroundTextFieldsColor()
        return textField
    }()

    private let labelStackView = UIStackView()
    private let buttonStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
        configureStackViews()
        configureButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SelectWeekDaysCellModel else {
            return
        }
        
        callbackResult = model.callbackResult
    }

    private func configure() {

        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtons.axis = .horizontal
        stackViewButtons.alignment = .center
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.spacing = 5

        for _ in 0..<7 {
            let button = ATYWeekDaysButton()
            weekDaysButton.append(button)
        }

        for i in 0..<weekDaysButton.count {
            weekDaysButton[i].snp.makeConstraints { (make) in
                make.height.equalTo(38)
            }
            weekDaysButton[i].layer.cornerRadius = 19
            weekDaysButton[i].backgroundColor = R.color.backgroundTextFieldsColor()
            weekDaysButton[i].setTitle(titlesForButton[i], for: .normal)
            weekDaysButton[i].setTitleColor(R.color.textSecondaryColor(), for: .normal)
            weekDaysButton[i].setTitleColor(R.color.backgroundTextFieldsColor(), for: .selected)
            weekDaysButton[i].addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            stackViewButtons.addArrangedSubview(weekDaysButton[i])
        }

        contentView.addSubview(stackViewButtons)

        stackViewButtons.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
        }
    }

    @objc func buttonAction(_ sender: UIButton!) {
        sender.isSelected = !sender.isSelected
        resultString = ""
        for button in weekDaysButton {
            if button.isSelected {
                resultString.append("1")
            } else {
                resultString.append("0")
            }
        }
        callbackResult?(resultString)
    }

    private func configureButtons() {
        startTextField.layer.cornerRadius = 22.5
        endTextField.layer.cornerRadius = 22.5
    }

    private func configureStackViews() {

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 44))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.datePickerDone))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        startTextField.inputAccessoryView = toolBar
        startTextField.inputView = datePicker
        startTextField.layer.cornerRadius = 19

        endTextField.inputAccessoryView = toolBar
        endTextField.inputView = datePicker
        endTextField.layer.cornerRadius = 19

        let calendarImageView = UIImageView(frame: CGRect(x: 0, y: 2, width: 26, height: 26))
        calendarImageView.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        calendarImageView.tintColor = R.color.textSecondaryColor()

        let backViewFirst = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backViewFirst.addSubview(calendarImageView)

        let calendarImageViewSecond = UIImageView(frame: CGRect(x: 0, y: 2, width: 26, height: 26))
        calendarImageViewSecond.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        calendarImageViewSecond.tintColor = R.color.textSecondaryColor()

        let backViewSecond = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        backViewSecond.addSubview(calendarImageViewSecond)

        endTextField.leftView = backViewFirst
        endTextField.delegate = self
        endTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
        endTextField.tintColor = .clear

        startTextField.leftView = backViewSecond
        startTextField.delegate = self
        startTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
        startTextField.tintColor = .clear

        labelStackView.axis = .horizontal
        labelStackView.alignment = .center
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = 5

        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 40

        startTextField.snp.makeConstraints { (make) in
            make.height.equalTo(45)
        }

        endTextField.snp.makeConstraints { (make) in
            make.height.equalTo(45)
        }

        labelStackView.addArrangedSubview(startLabel)
        labelStackView.addArrangedSubview(endLabel)

        buttonStackView.addArrangedSubview(startTextField)
        buttonStackView.addArrangedSubview(endTextField)

        contentView.addSubview(labelStackView)
        contentView.addSubview(buttonStackView)

        labelStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(stackViewButtons.snp.bottom).offset(10)
        }

        buttonStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-60)
            make.top.equalTo(labelStackView).offset(30)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    @objc func dateChanged() {
        if startTextField.isFirstResponder {
            startTextField.text = datePicker.date.toString(dateFormat: .simpleDateFormatFullYear)
        } else {
            endTextField.text = datePicker.date.toString(dateFormat: .simpleDateFormatFullYear)
        }
    }

    @objc func datePickerDone() {
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
    }
}
