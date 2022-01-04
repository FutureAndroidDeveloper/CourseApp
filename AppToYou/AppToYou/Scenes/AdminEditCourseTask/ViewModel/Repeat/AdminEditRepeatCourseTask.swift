import Foundation
import XCoordinator


class AdminEditRepeatCourseTask: CreateRepeatUserTaskViewModel {
    private let constructor: AdminEditRepeatCourseTaskConstructor
    
     init(type: ATYTaskType, constructor: AdminEditRepeatCourseTaskConstructor,
          mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
         
        self.constructor = constructor
        super.init(type: type, constructor: constructor.baseConstructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func getValidator() -> RitualCourseTaskValidator {
        return RitualCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.construct()
    }
    
    func setDataSource(dataSource: CounterTaskDataSource?) {
        constructor.baseConstructor.setDataSource(dataSource: dataSource)
    }
    
    override func validate(model: RepeatCreateTaskModel) -> Bool {
        let validator: RitualTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
}
