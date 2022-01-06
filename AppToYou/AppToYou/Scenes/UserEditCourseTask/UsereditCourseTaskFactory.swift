import Foundation
import XCoordinator


class UsereditCourseTaskFactory {
    private let task: UserTaskResponse
    private let mode: CreateTaskMode
    
    init(task: UserTaskResponse, mode: CreateTaskMode) {
        self.task = task
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch task.taskType {
        case .CHECKBOX:
            let constructor = UserEditCourseTaskConstructor(mode: mode, model: UserEditCourseTaskModel())
            return UserEditCourseTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TEXT:
            let constructor = UserEditTextCourseTaskConstructor(mode: mode, model: UserEditTextCourseTaskModel())
            return UserEditTextCourseTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TIMER:
            let constructor = UserEditTimerCourseTaskConstructor(mode: mode, model: UserEditTimerCourseTaskModel())
            return UserEditTimerCourseTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)
            
        case .RITUAL:
            let constructor = UserEditRepeatCourseTaskConstructor(mode: mode, model: UserEditRepeatCourseTaskModel())
            return UserEditRepeatCourseTaskViewModel(userTask: task, constructor: constructor, mode: mode, taskRouter: router)

        }
    }
    
}
