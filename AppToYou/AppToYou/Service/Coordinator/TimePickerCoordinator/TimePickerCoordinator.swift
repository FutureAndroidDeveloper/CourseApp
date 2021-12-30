import UIKit
import XCoordinator


enum TimePickerRoute: Route {
    case picker
    case notificationTimePicked(_ time: NotificationTime)
    case userTaskDurationPicked(_ duration: DurationTime)
    case courseTaskDurationPicked(_ duration: Duration)
    case courseDuration(_ duration: Duration)
}


class TimePickerCoordinator: NavigationCoordinator<TimePickerRoute> {
    
    private let type: TimePickerType
    private weak var pickerDelegate: TimePickerDelegate?
    
    init(type: TimePickerType, pickerDelegate: TimePickerDelegate?, rootViewController: RootViewController) {
        self.type = type
        self.pickerDelegate = pickerDelegate
        super.init(rootViewController: rootViewController)
        trigger(.picker)
        
    }
    
    override func prepareTransition(for route: TimePickerRoute) -> NavigationTransition {
        switch route {
        case .picker:
            let timePickerViewController = ATYSelectTimeViewController()
            let timePickerViewModel = SelectTimeViewModelImpl(pickerType: type, router: unownedRouter)
            timePickerViewController.bind(to: timePickerViewModel)

            return .present(timePickerViewController, animation: nil)
            
        case .notificationTimePicked(let time):
            pickerDelegate?.notificationPicked(time)
            return .dismiss()
            
        case .userTaskDurationPicked(let duration):
            pickerDelegate?.userTaskdurationPicked(duration)
            
        case .courseTaskDurationPicked(let duration):
            pickerDelegate?.courseTaskDurationPicked(duration)
            
        case .courseDuration(let duration):
            pickerDelegate?.courseDurationPicked(duration)
        }
        
        return .dismiss()
    }
    
}
