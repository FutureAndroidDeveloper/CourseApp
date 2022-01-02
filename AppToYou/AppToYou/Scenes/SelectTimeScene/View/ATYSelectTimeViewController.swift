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
