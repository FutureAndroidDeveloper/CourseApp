import UIKit
import XCoordinator


enum TimePickerRoute: Route {
    case picker
    case notificationTimePicked(_ time: NotificationTime)
    case userTaskDurationPicked(_ duration: DurationTime)
    case courseTaskDurationPicked(_ duration: Duration)
    case courseDuration(_ duration: Duration)
}


class TimePickerCoordinator: ViewCoordinator<TimePickerRoute> {
    
    private let type: TimePickerType
    private weak var pickerDelegate: TimePickerDelegate?
    
    init(type: TimePickerType, pickerDelegate: TimePickerDelegate?, rootViewController: RootViewController) {
        self.type = type
        self.pickerDelegate = pickerDelegate
        super.init(rootViewController: rootViewController)
        trigger(.picker)
    }
    
    override func prepareTransition(for route: TimePickerRoute) -> ViewTransition {
        let timePickerViewController = ATYSelectTimeViewController()
        let timePickerViewModel = SelectTimeViewModelImpl(pickerType: type, router: unownedRouter)
        timePickerViewController.bind(to: timePickerViewModel)
        
        let bottomSheetCoordinator = BottomSheetCoordinator(rootViewController: self.rootViewController)
        
        switch route {
        case .picker:
            addChild(bottomSheetCoordinator)
            return .route(.show(timePickerViewController), on: bottomSheetCoordinator)
            
        case .notificationTimePicked(let time):
            pickerDelegate?.notificationPicked(time)
            
        case .userTaskDurationPicked(let duration):
            pickerDelegate?.userTaskdurationPicked(duration)
            
        case .courseTaskDurationPicked(let duration):
            pickerDelegate?.courseTaskDurationPicked(duration)
            
        case .courseDuration(let duration):
            pickerDelegate?.courseDurationPicked(duration)
        }
        
        removeChild(bottomSheetCoordinator)
        removeChildrenIfNeeded()
        return .trigger(.close, on: bottomSheetCoordinator)
    }
    
}
