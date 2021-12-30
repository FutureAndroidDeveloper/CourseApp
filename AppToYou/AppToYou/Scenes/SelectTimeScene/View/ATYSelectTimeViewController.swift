//
//  ATYSelectTimeScene.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYSelectTimeViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    var viewModel: SelectTimeViewModel!
    
    private lazy var dataProvider: TimePickerDataSource = {
        let type = viewModel.output.getPickerType()
        let dataSource = TimePickerDataSource(type: type)
        return dataSource
    }()
    
    private let pickerContainer = UIView()
    private var pickerView: UIView?

    var saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Добавить напоминание", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        return button
    }()

    // TODO: - удалить это свойство, т.к. передача ввремени происходит через VM
    var callBackTime: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        configureButton()
        configure()
    }

    private func configure() {
        view.addSubview(pickerContainer)
        pickerContainer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(saveButton.snp.top).offset(-30)
            make.height.equalTo(215)
        }
    }

    private func configureButton() {
        view.addSubview(saveButton)
        saveButton.layer.cornerRadius = 22.5
        saveButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.edgeInsets)
            $0.height.equalTo(45)
        }
    }
    
    func bindViewModel() {
        let type = viewModel.output.getPickerType()
        
        switch type {
        case .userTaskDuration, .courseTaskDuration, .course:
            let picker = UIPickerView()
            picker.dataSource = dataProvider
            picker.delegate = dataProvider
            
            pickerView = picker
            pickerContainer.addSubview(picker)
            picker.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            picker.reloadAllComponents()
            saveButton.addTarget(self, action: #selector(getDurationTime), for: .touchUpInside)
            
        case .notification:
            let picker = UIDatePicker()
            picker.datePickerMode = .time
            picker.preferredDatePickerStyle = .wheels

            pickerView = picker
            pickerContainer.addSubview(picker)
            picker.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            saveButton.addTarget(self, action: #selector(getNotificationTime), for: .touchUpInside)
        }
    }

    @objc
    private func getNotificationTime() {
        guard let timePicker = pickerView as? UIDatePicker else {
            return
        }
        let comp = timePicker.calendar.dateComponents([.hour, .minute], from: timePicker.date)
        let hour = String(comp.hour ?? 0)
        let minutes = String(comp.minute ?? 0)
        let notifiaction = NotificationTime(hour: hour, min: minutes)
        
        viewModel.input.notificationTimePicked(notifiaction)
    }
    
    @objc
    private func getDurationTime() {
        guard
            let timePicker = pickerView as? UIPickerView,
            let dataSource = timePicker.dataSource as? TimePickerDataSource
        else {
            return
        }
        
        let type = viewModel.output.getPickerType()
        if type == .userTaskDuration {
            viewModel.input.userTaskDurationPicked(dataSource.taskDuration)
        } else if type == .course {
            viewModel.input.courseDurationPicked(dataSource.courseDuration)
        } else if type == .courseTaskDuration {
            viewModel.input.courseTaskDurationPicked(dataSource.courseDuration)
        }
    }
    
}

enum TimePickerType {
    case userTaskDuration
    case courseTaskDuration
    case course
    case notification
    
    var components: Int {
        switch self {
        case .userTaskDuration, .courseTaskDuration, .course:
            return 3
        case .notification:
            return 0
        }
    }
    
    func getNumberOfRows(for component: Int) -> Int {
        switch component {
        case 0:
            switch self {
            case .userTaskDuration: return 24
            case .courseTaskDuration, .course: return 20
            default: return 0
            }
        case 1, 2:
            switch self {
            case .userTaskDuration: return 60
            case .courseTaskDuration, .course: return 12
            default: return 0
            }
        default:
            return 0
        }
    }
}

//enum TaskDuration {
//    case user(duration: DurationTime)
//    case course(duration: Duration)
//}

class TimePickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var firstComponentValue: Int = 0
    private var secondComponentValue: Int = 0
    private var thirdComponentValue: Int = 0
    
    var taskDuration: DurationTime {
        return DurationTime(hour: "\(firstComponentValue)",
                            min: "\(secondComponentValue)",
                            sec: "\(thirdComponentValue)")
    }
    
    var courseDuration: Duration {
        return Duration(day: firstComponentValue, month: secondComponentValue, year: thirdComponentValue)
    }
    
    private let type: TimePickerType
    
    init(type: TimePickerType) {
        self.type = type
        super.init()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type.components
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.getNumberOfRows(for: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: firstComponentValue = row
        case 1: secondComponentValue = row
        case 2: thirdComponentValue = row
        default: break
        }
    }
    
}
