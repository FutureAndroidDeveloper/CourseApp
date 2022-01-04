import Foundation
import XCoordinator


class AdminEditTimerCourseTask: CreateTimerUserTaskViewModel {
    private let constructor: AdminEditTimerCourseTaskConstructor
    
     init(type: ATYTaskType, constructor: AdminEditTimerCourseTaskConstructor,
          mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
         
        self.constructor = constructor
        super.init(type: type, constructor: constructor.baseConstructor, mode: mode, taskRouter: taskRouter)
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
