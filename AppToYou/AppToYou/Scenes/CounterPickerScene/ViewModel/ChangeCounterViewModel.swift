import Foundation


protocol ChangeCounterViewModelInput {
    func countPicked(_ count: Int)
}

protocol ChangeCounterViewModelOutput {
}


protocol ChangeCounterViewModel {
    var input: ChangeCounterViewModelInput { get }
    var output: ChangeCounterViewModelOutput { get }
}

extension ChangeCounterViewModel where Self: ChangeCounterViewModelInput & ChangeCounterViewModelOutput {
    var input: ChangeCounterViewModelInput { return self }
    var output: ChangeCounterViewModelOutput { return self }
}
