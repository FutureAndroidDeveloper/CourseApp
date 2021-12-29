import Foundation
import XCoordinator


class CreateTaskFactory {
    
    private let type: ATYTaskType
    private let task: UserTaskResponse?
    private let mode: CreateTaskMode
    
    init(type: ATYTaskType, task: UserTaskResponse?, mode: CreateTaskMode) {
        self.type = type
        self.task = task
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TasksRoute>) -> CreateTaskViewModel {
        switch type {
        case .CHECKBOX:
            return DefaultCreateTaskViewModel(type: type, task: task, mode: mode, router: router)
        case .TEXT:
            return TextCreateTaskViewModel(type: type, task: task, mode: mode, router: router)
        case .TIMER:
            return TimerCreateTaskViewModel(type: type, task: task, mode: mode, router: router)
        case .RITUAL:
            return RepeatCreateTaskViewModel(type: type, task: task, mode: mode, router: router)
        }
    }
    
}
