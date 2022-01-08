import UIKit



class ATYSelectTimeViewController: UIViewController, BindableType {
    private struct Constants {
        static let pickerInsets = UIEdgeInsets(top: 45, left: 20, bottom: 0, right: 20)
        static let buttonInsets = UIEdgeInsets(top: 17, left: 20, bottom: 47, right: 20)
        static let buttonHeight: CGFloat = 45
    }
    
    var viewModel: SelectTimeViewModel!
    
    private let pickerContainer = UIView()
    private var pickerView: UIView?
    
    private lazy var dataProvider: TimePickerDataSource = {
        let type = viewModel.output.getPickerType()
        let dataSource = TimePickerDataSource(type: type)
        return dataSource
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        return button
    }()

    // TODO: - удалить это свойство, т.к. передача ввремени происходит через VM
    var callBackTime: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
    }

    private func configure() {
        view.addSubview(pickerContainer)
        pickerContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.pickerInsets)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(pickerContainer.snp.bottom).offset(Constants.buttonInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.buttonInsets)
            $0.height.equalTo(Constants.buttonHeight)
        }
    }
    
    func bindViewModel() {
        let type = viewModel.output.getPickerType()
        saveButton.setTitle(type.title, for: .normal)
        
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
