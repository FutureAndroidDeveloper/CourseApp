import Foundation
import XCoordinator

protocol SelectTimeViewModelInput {
    func userTaskDurationPicked(_ duration: DurationTime)
    func courseDurationPicked(_ duration: Duration)
    func courseTaskDurationPicked(_ duration: Duration)
    func notificationTimePicked(_ notification: NotificationTime)
}

protocol SelectTimeViewModelOutput {
    func getPickerType() -> TimePickerType
}



protocol SelectTimeViewModel {
    var input: SelectTimeViewModelInput { get }
    var output: SelectTimeViewModelOutput { get }
}

extension SelectTimeViewModel where Self: SelectTimeViewModelInput & SelectTimeViewModelOutput {
    var input: SelectTimeViewModelInput { return self }
    var output: SelectTimeViewModelOutput { return self }
}


class SelectTimeViewModelImpl: SelectTimeViewModel, SelectTimeViewModelInput, SelectTimeViewModelOutput {

    private let router: UnownedRouter<TimePickerRoute>
    private let pickerType: TimePickerType

    init(pickerType: TimePickerType, router: UnownedRouter<TimePickerRoute>) {
        self.pickerType = pickerType
        self.router = router
    }
    
    func userTaskDurationPicked(_ duration: DurationTime)  {
        router.trigger(.userTaskDurationPicked(duration))
    }
    
    func courseDurationPicked(_ duration: Duration) {
        router.trigger(.courseDuration(duration))
    }
    
    func courseTaskDurationPicked(_ duration: Duration) {
        router.trigger(.courseTaskDurationPicked(duration))
    }
    
    func notificationTimePicked(_ notification: NotificationTime) {
        router.trigger(.notificationTimePicked(notification))
    }
    
    func getPickerType() -> TimePickerType {
        return pickerType
    }
    
}
