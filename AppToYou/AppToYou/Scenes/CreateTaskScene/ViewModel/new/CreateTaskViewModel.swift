import Foundation


protocol CreateTaskViewModelInput {
    func notificationTimePicked(_ time: NotificationTime)
    func durationTimePicked(_ time: DurationTime)
}

protocol CreateTaskViewModelOutput {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CreateTaskViewModel {
    var input: CreateTaskViewModelInput { get }
    var output: CreateTaskViewModelOutput { get }
}

extension CreateTaskViewModel where Self: CreateTaskViewModelInput & CreateTaskViewModelOutput {
    var input: CreateTaskViewModelInput { return self }
    var output: CreateTaskViewModelOutput { return self }
}
