import Foundation
import XCoordinator


class AdminEditTextCourseTask: CreateTextUserTaskViewModel {
    private let constructor: AdminEditTextCourseTaskConstructor
    
     init(type: TaskType, constructor: AdminEditTextCourseTaskConstructor, mode: CreateTaskMode,
          synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
         
        self.constructor = constructor
         super.init(type: type, constructor: constructor.baseConstructor, mode: mode,
                    synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func getValidator() -> TextTaskValidator {
        return TextCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.construct()
    }
    
    func setDataSource(dataSource: TextTaskDataSource?) {
        constructor.baseConstructor.setDataSource(dataSource: dataSource)
    }
    
    override func validate(model: TextCreateTaskModel) -> Bool {
        let validator: TextTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
}
