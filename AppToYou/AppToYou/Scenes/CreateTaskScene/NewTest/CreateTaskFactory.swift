import Foundation
import XCoordinator


class CreateTaskFactory {
    
    private let type: ATYTaskType
    
    init(type: ATYTaskType) {
        self.type = type
    }
    
    func getViewModel(_ router: UnownedRouter<TasksRoute>) -> CreateTaskViewModel {
        switch type {
        case .CHECKBOX:
            return DefaultCreateTaskViewModel(router: router)
        case .TEXT:
            return TextCreateTaskViewModel(router: router)
        case .TIMER:
            return TimerCreateTaskViewModel(router: router)
        case .RITUAL:
            return RepeatCreateTaskViewModel(router: router)
        }
    }
    
}
