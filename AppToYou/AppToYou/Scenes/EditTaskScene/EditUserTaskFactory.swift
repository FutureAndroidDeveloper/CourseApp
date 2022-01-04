import Foundation
import XCoordinator


class EditUserTaskFactory {
    private let task: UserTaskResponse
    private let mode: CreateTaskMode
    
    init(task: UserTaskResponse, mode: CreateTaskMode) {
        self.task = task
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch task.taskType {
        case .CHECKBOX:
            let constructor = CheckboxTaskConstructor(mode: mode, model: DefaultCreateTaskModel())
            return EditUserTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TEXT:
            let constructor = TextTaskConstructor(mode: mode, model: TextCreateTaskModel())
            return EditTextUserTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
        case .TIMER:
            let constructor = TimerTaskConstructor(mode: mode, model: TimerCreateTaskModel())
            return EditTimerUserTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
            
        case .RITUAL:
            let constructor = RepeatTaskConstructor(mode: mode, model: RepeatCreateTaskModel())
            return EditRepeatUserTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
        }
    }
    
}

