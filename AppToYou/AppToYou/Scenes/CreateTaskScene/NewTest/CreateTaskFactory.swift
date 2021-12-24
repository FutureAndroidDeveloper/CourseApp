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
            return DefaultCreateTaskViewModel(type: type, router: router)
        case .TEXT:
            return TextCreateTaskViewModel(type: type,router: router)
        case .TIMER:
            return TimerCreateTaskViewModel(type: type, router: router)
        case .RITUAL:
            return RepeatCreateTaskViewModel(type: type, router: router)
        }
    }
    
}
