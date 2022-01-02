import Foundation
import XCoordinator


class CreateTaskFactory {
    private let type: ATYTaskType
    private let mode: CreateTaskMode
    
    private var userTask: UserTaskResponse?
    private var courseTask: CourseTaskResponse?
    
    convenience init(type: ATYTaskType, mode: CreateTaskMode, userTask: UserTaskResponse?) {
        self.init(type: type, mode: mode)
        self.userTask = userTask
        self.courseTask = nil
    }
    
    convenience init(type: ATYTaskType, mode: CreateTaskMode, courseTask: CourseTaskResponse?) {
        self.init(type: type, mode: mode)
        self.courseTask = courseTask
        self.userTask = nil
    }
    
    init(type: ATYTaskType, mode: CreateTaskMode) {
        self.type = type
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        switch type {
        case .CHECKBOX:
            let constructor = CheckboxTaskConstructor(mode: mode, model: DefaultCreateTaskModel())
            return CreateUserTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TEXT:
            let constructor = TextTaskConstructor(mode: mode, model: TextCreateTaskModel())
            return CreateTextUserTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TIMER:
            let constructor = TimerTaskConstructor(mode: mode, model: TimerCreateTaskModel())
            return CreateTimerUserTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .RITUAL:
            let constructor = RepeatTaskConstructor(mode: mode, model: RepeatCreateTaskModel())
            return CreateRepeatUserTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
        }
    }
    
}
