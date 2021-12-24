import UIKit
import XCoordinator


enum TimePickerRoute: Route {
    case picker
    case notificationTimePicked(_ time: NotificationTime)
    case durationTimePicked(_ time: DurationTime)
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
            
        case .durationTimePicked(let duration):
            pickerDelegate?.durationPicked(duration)
            return .dismiss()
        }
    }
    
}
