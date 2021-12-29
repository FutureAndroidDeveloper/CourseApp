import Foundation


protocol CreateTaskViewModelInput: TimePickerDelegate {
    func saveDidTapped()
}

protocol CreateTaskViewModelOutput: AnyObject {
    var sections: Observable<[TableViewSection]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CreateTaskViewModel: AnyObject {
    var input: CreateTaskViewModelInput { get }
    var output: CreateTaskViewModelOutput { get }
}

extension CreateTaskViewModel where Self: CreateTaskViewModelInput & CreateTaskViewModelOutput {
    var input: CreateTaskViewModelInput { return self }
    var output: CreateTaskViewModelOutput { return self }
}
