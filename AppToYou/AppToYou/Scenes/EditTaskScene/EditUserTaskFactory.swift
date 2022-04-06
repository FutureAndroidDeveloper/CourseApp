import Foundation
import XCoordinator


class EditUserTaskFactory {
    private let task: Task
    private let mode: CreateTaskMode
    private let synchronizationService: SynchronizationService
    
    init(task: Task, mode: CreateTaskMode, synchronizationService: SynchronizationService) {
        self.task = task
        self.mode = mode
        self.synchronizationService = synchronizationService
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch task.taskType {
        case .CHECKBOX:
            let constructor = CheckboxTaskConstructor(mode: mode, model: DefaultCreateTaskModel())
            return EditUserTaskViewModel(
                task: task,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
            
        case .TEXT:
            let constructor = TextTaskConstructor(mode: mode, model: TextCreateTaskModel())
            return EditTextUserTaskViewModel(
                task: task,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
        case .TIMER:
            let constructor = TimerTaskConstructor(mode: mode, model: TimerCreateTaskModel())
            return EditTimerUserTaskViewModel(
                task: task,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
            
        case .RITUAL:
            let constructor = RepeatTaskConstructor(mode: mode, model: RepeatCreateTaskModel())
            return EditRepeatUserTaskViewModel(
                task: task,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
        }
    }
    
}

