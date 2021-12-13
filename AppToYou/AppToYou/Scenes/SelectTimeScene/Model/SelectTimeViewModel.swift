import Foundation
import XCoordinator

protocol SelectTimeViewModelInput {
    func timePicked(hour: String, min: String, sec: String?)
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

    private let router: UnownedRouter<TasksRoute>
    private let pickerType: TimePickerType

    init(pickerType: TimePickerType, router: UnownedRouter<TasksRoute>) {
        self.pickerType = pickerType
        self.router = router
    }
    
    func timePicked(hour: String, min: String, sec: String?) {
        if let second = sec {
            let time = DurationTime(hour: hour, min: min, sec: second)
            router.trigger(.durationTimePicked(time))
        } else {
            let time = NotificationTime(hour: hour, min: min)
            router.trigger(.notificationTimePicked(time))
        }
    }
    
    func getPickerType() -> TimePickerType {
        return pickerType
    }
    
}
