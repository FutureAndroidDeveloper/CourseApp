import Foundation
import XCoordinator


class AdminEditTimerCourseTask: CreateTimerUserTaskViewModel {
    private let constructor: AdminEditTimerCourseTaskConstructor
    
     init(type: TaskType, constructor: AdminEditTimerCourseTaskConstructor, mode: CreateTaskMode,
          synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
         
        self.constructor = constructor
         super.init(type: type, constructor: constructor.baseConstructor, mode: mode,
                    synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func getValidator() -> TimerTaskValidator {
        return TimerCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.construct()
    }
    
    func setDataSource(dataSource: TimerTaskDataSource?) {
        constructor.baseConstructor.setDataSource(dataSource: dataSource)
    }
    
    override func validate(model: TimerCreateTaskModel) -> Bool {
        let validator: TimerTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
}
