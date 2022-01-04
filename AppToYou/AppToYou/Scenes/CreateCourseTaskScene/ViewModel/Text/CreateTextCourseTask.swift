import Foundation
import XCoordinator


/**
 Класс, который переопределяет поведение поял минимального числа символов для создания курсовой задачи.
 */
class CreateTextCourseTask: CreateTextUserTaskViewModel {
    
    private let constructor: CreateTextCourseTaskConstructor
    
     init(type: ATYTaskType, constructor: CreateTextCourseTaskConstructor,
          mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>)
    {
        self.constructor = constructor
        super.init(type: type, constructor: constructor.baseConstructor,
                   mode: mode, taskRouter: taskRouter)
    }
    
    override func getValidator() -> TextTaskValidator {
        return TextCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.construct()
    }
    
    override func validate(model: TextCreateTaskModel) -> Bool {
        let validator: TextTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
    override func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let (fieldModel, _) = super.getMinSymbolsModel()
        let lockModel = LockButtonModel(isLocked: false)
        return (fieldModel, lockModel)
    }
    
}
