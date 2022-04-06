import Foundation
import XCoordinator


class UsereditCourseTaskFactory {
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
            let constructor = UserEditCourseTaskConstructor(mode: mode, model: UserEditCourseTaskModel())
            return UserEditCourseTaskViewModel(
                task: task, constructor: constructor, mode: mode,
                synchronizationService: synchronizationService, taskRouter: router
            )
            
        case .TEXT:
            let constructor = UserEditTextCourseTaskConstructor(mode: mode, model: UserEditTextCourseTaskModel())
            return UserEditTextCourseTaskViewModel(
                task: task, constructor: constructor, mode: mode,
                synchronizationService: synchronizationService, taskRouter: router
            )
            
        case .TIMER:
            let constructor = UserEditTimerCourseTaskConstructor(mode: mode, model: UserEditTimerCourseTaskModel())
            return UserEditTimerCourseTaskViewModel(
                task: task, constructor: constructor, mode: mode,
                synchronizationService: synchronizationService, taskRouter: router
            )
            
        case .RITUAL:
            let constructor = UserEditRepeatCourseTaskConstructor(mode: mode, model: UserEditRepeatCourseTaskModel())
            return UserEditRepeatCourseTaskViewModel(
                task: task, constructor: constructor, mode: mode,
                synchronizationService: synchronizationService, taskRouter: router
            )

        }
    }
    
}
