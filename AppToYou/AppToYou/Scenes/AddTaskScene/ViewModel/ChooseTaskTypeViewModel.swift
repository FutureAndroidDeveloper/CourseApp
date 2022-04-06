import Foundation


protocol ChooseTaskTypeViewModelInput {
    func typePicked(_ taskType: TaskType)
}


protocol ChooseTaskTypeViewModelOutput {
    var sections: Observable<[TableViewSection]> { get }
    var updatedState: Observable<Void> { get }
}


protocol ChooseTaskTypeViewModel {
    var input: ChooseTaskTypeViewModelInput { get }
    var output: ChooseTaskTypeViewModelOutput { get }
}

extension ChooseTaskTypeViewModel where Self: ChooseTaskTypeViewModelInput & ChooseTaskTypeViewModelOutput {
    var input: ChooseTaskTypeViewModelInput { return self }
    var output: ChooseTaskTypeViewModelOutput { return self }
}
