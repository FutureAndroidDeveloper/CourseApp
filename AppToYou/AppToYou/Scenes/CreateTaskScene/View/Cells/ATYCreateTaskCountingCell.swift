//
//  ATYCreateTaskCountingCell.swift
//  AppToYou
//
//  Created by Philip Bratov on 28.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateTaskCountingCell: UITableViewCell {

    var countingLabel : UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.frequencyOfExecution()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let radioController: RadioButtonController = RadioButtonController()

    var radioButtonOne : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.daily(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var radioButtonTwo : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.onWeekdays(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var radioButtonThree : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.monthly(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var radioButtonFour : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.everyYear(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var radioButtonFive : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.once(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var radioButtonSix : UIButton = {
        let button = UIButton()
        button.setImage(R.image.unselectedRadioButton(), for: .normal)
        button.setImage(R.image.selectedRadioButton(), for: .selected)
        button.setTitle(R.string.localizable.selectDaysWeek(), for: .normal)
        button.setTitleColor(R.color.titleTextColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = R.color.backgroundTextFieldsColor()
        button.centerTextAndImage(spacing: 10)
        return button
    }()

    var oneRepeatCallback : ((ATYFrequencyTypeEnum) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        configeureNameLabel()
        configeureRadioButton()
        radioController.buttonsArray = [radioButtonOne,radioButtonTwo,radioButtonThree,radioButtonFour,radioButtonFive,radioButtonSix]
        radioController.defaultButton = radioButtonOne
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configeureNameLabel() {
        contentView.addSubview(countingLabel)
        countingLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func configeureRadioButton() {
        contentView.addSubview(radioButtonOne)
        contentView.addSubview(radioButtonTwo)
        contentView.addSubview(radioButtonThree)
        contentView.addSubview(radioButtonFour)
        contentView.addSubview(radioButtonFive)
        contentView.addSubview(radioButtonSix)


        //Configure first line buttons
        radioButtonOne.layer.cornerRadius = 17.5
        radioButtonOne.addTarget(self, action: #selector(actionRadioButton(_:)), for: .touchUpInside)
        radioButtonOne.snp.makeConstraints { (make) in
            make.top.equalTo(self.countingLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
        }

        radioButtonTwo.layer.cornerRadius = 17.5
        radioButtonTwo.addTarget(self, action: #selector(actionRadioButtonTwo(_:)), for: .touchUpInside)
        radioButtonTwo.snp.makeConstraints { (make) in
            make.top.equalTo(self.countingLabel.snp.bottom).offset(15)
            make.leading.equalTo(self.radioButtonOne.snp.trailing).offset(15)
            make.height.equalTo(35)
        }

        //Configure second line buttons
        radioButtonThree.layer.cornerRadius = 17.5
        radioButtonThree.addTarget(self, action: #selector(actionRadioButtonThree(_:)), for: .touchUpInside)
        radioButtonThree.snp.makeConstraints { (make) in
            make.top.equalTo(self.radioButtonOne.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
        }

        radioButtonFour.layer.cornerRadius = 17.5
        radioButtonFour.addTarget(self, action: #selector(actionRadioButtonFour(_:)), for: .touchUpInside)
        radioButtonFour.snp.makeConstraints { (make) in
            make.top.equalTo(self.radioButtonTwo.snp.bottom).offset(10)
            make.leading.equalTo(self.radioButtonThree.snp.trailing).offset(15)
            make.height.equalTo(35)
        }

        //Configure third line buttons

        radioButtonFive.layer.cornerRadius = 17.5
        radioButtonFive.addTarget(self, action: #selector(actionRadioButtonFive(_:)), for: .touchUpInside)
        radioButtonFive.snp.makeConstraints { (make) in
            make.top.equalTo(self.radioButtonThree.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-15)
        }

        radioButtonSix.layer.cornerRadius = 17.5
        radioButtonSix.addTarget(self, action: #selector(actionRadioButtonSix(_:)), for: .touchUpInside)
        radioButtonSix.snp.makeConstraints { (make) in
            make.top.equalTo(self.radioButtonFour.snp.bottom).offset(10)
            make.leading.equalTo(self.radioButtonFive.snp.trailing).offset(15)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

    @objc func actionRadioButton(_ sender: UIButton) {
        oneRepeatCallback?(.EVERYDAY)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonTwo(_ sender: UIButton) {
        oneRepeatCallback?(.WEEKDAYS)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonThree(_ sender: UIButton) {
        oneRepeatCallback?(.MONTHLY)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonFour(_ sender: UIButton) {
        oneRepeatCallback?(.YEARLY)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonFive(_ sender: UIButton) {
        oneRepeatCallback?(.ONCE)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

    @objc func actionRadioButtonSix(_ sender: UIButton) {
        oneRepeatCallback?(.CERTAIN_DAYS)
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }

}
