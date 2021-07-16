//
//  ATYSelectTimeScene.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSelectTimeViewController: UIViewController {

    let lineView = UIView()

    let timePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        return picker
    }()

    var saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Добавить напоминание", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        return button
    }()

    var callBackTime: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        configureLineView()
        configureButton()
        configure()
    }

    private func configure() {
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(saveButton.snp.top).offset(-30)
        }
    }

    private func configureButton() {
        view.addSubview(saveButton)
        saveButton.layer.cornerRadius = 22.5
        saveButton.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
        saveButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
    }

    private func configureLineView() {
        view.addSubview(lineView)
        lineView.backgroundColor = R.color.lightGrayColor()
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
    }

    @objc func actionButtonTap() {
        let comp = timePicker.calendar.dateComponents([.hour, .minute], from: timePicker.date)
        let hour = String(comp.hour ?? 0)
        let minute = String(comp.minute ?? 0)

        self.dismiss(animated: true) {
            self.callBackTime?(hour, minute)
        }
    }
}
