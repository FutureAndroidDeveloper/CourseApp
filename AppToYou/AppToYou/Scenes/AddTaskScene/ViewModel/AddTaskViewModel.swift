import Foundation
import XCoordinator

protocol AddTaskViewModelInput {
    func typePicked(_ taskType: ATYTaskType)
}

protocol AddTaskViewModelOutput {
    
}



protocol AddTaskViewModel {
    var input: AddTaskViewModelInput { get }
    var output: AddTaskViewModelOutput { get }
}

extension AddTaskViewModel where Self: AddTaskViewModelInput & AddTaskViewModelOutput {
    var input: AddTaskViewModelInput { return self }
    var output: AddTaskViewModelOutput { return self }
}


class AddTaskViewModelImpl: AddTaskViewModel, AddTaskViewModelInput, AddTaskViewModelOutput {

    private let router: UnownedRouter<TaskRoute>

    init(router: UnownedRouter<TaskRoute>) {
        self.router = router
    }
    
    func typePicked(_ taskType: ATYTaskType) {
        router.trigger(.create(taskType))
    }
    
}
