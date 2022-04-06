import Foundation
import XCoordinator


class CreateTaskFactory {
    private let type: TaskType
    private let mode: CreateTaskMode
    private let synchronizationService: SynchronizationService
    
    private var userTask: UserTaskResponse?
    private var courseTask: CourseTaskResponse?
    
    convenience init(type: TaskType, mode: CreateTaskMode, synchronizationService: SynchronizationService, userTask: UserTaskResponse?) {
        self.init(type: type, mode: mode, synchronizationService: synchronizationService)
        self.userTask = userTask
        self.courseTask = nil
    }
    
    convenience init(type: TaskType, mode: CreateTaskMode, synchronizationService: SynchronizationService, courseTask: CourseTaskResponse?) {
        self.init(type: type, mode: mode, synchronizationService: synchronizationService)
        self.courseTask = courseTask
        self.userTask = nil
    }
    
    init(type: TaskType, mode: CreateTaskMode, synchronizationService: SynchronizationService) {
        self.type = type
        self.mode = mode
        self.synchronizationService = synchronizationService
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        switch type {
        case .CHECKBOX:
            let constructor = CheckboxTaskConstructor(mode: mode, model: DefaultCreateTaskModel())
            return CreateUserTaskViewModel(
                type: type,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
            
        case .TEXT:
            let constructor = TextTaskConstructor(mode: mode, model: TextCreateTaskModel())
            return CreateTextUserTaskViewModel(
                type: type,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
            
        case .TIMER:
            let constructor = TimerTaskConstructor(mode: mode, model: TimerCreateTaskModel())
            return CreateTimerUserTaskViewModel(
                type: type,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
            
        case .RITUAL:
            let constructor = RepeatTaskConstructor(mode: mode, model: RepeatCreateTaskModel())
            return CreateRepeatUserTaskViewModel(
                type: type,
                constructor: constructor,
                mode: mode,
                synchronizationService: synchronizationService,
                taskRouter: router
            )
        }
    }
    
}
