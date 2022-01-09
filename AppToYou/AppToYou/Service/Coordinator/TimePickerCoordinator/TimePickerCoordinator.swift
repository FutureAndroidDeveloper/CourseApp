import XCoordinator


enum TimePickerRoute: Route {
    case notificationTimePicked(_ time: NotificationTime)
    case userTaskDurationPicked(_ duration: DurationTime)
    case courseTaskDurationPicked(_ duration: Duration)
    case courseDuration(_ duration: Duration)
}


class TimePickerCoordinator: ViewCoordinator<TimePickerRoute> {
    
    private let type: TimePickerType
    private weak var pickerDelegate: TimePickerDelegate?
    weak var flowDelegate: FlowEndHandlerDelegate?
    
    init(type: TimePickerType, pickerDelegate: TimePickerDelegate?) {
        self.type = type
        self.pickerDelegate = pickerDelegate
        let timePickerViewController = ATYSelectTimeViewController()
        super.init(rootViewController: timePickerViewController)
        
        let timePickerViewModel = SelectTimeViewModelImpl(pickerType: type, router: unownedRouter)
        timePickerViewController.bind(to: timePickerViewModel)
    }
    
    override func prepareTransition(for route: TimePickerRoute) -> ViewTransition {
        switch route {
        case .notificationTimePicked(let time):
            pickerDelegate?.notificationPicked(time)
            
        case .userTaskDurationPicked(let duration):
            pickerDelegate?.userTaskdurationPicked(duration)
            
        case .courseTaskDurationPicked(let duration):
            pickerDelegate?.courseTaskDurationPicked(duration)
            
        case .courseDuration(let duration):
            pickerDelegate?.courseDurationPicked(duration)
        }
        
        flowDelegate?.flowDidEnd()
        return .none()
    }
    
}
