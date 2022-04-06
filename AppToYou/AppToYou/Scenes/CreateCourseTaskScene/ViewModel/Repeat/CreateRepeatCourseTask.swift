import Foundation
import XCoordinator


/**
 Класс, который переопределяет поведение поля счетчика повторений для создания курсовой задачи.
 */
class CreateRepeatCourseTask: CreateRepeatUserTaskViewModel {
    
    private let constructor: CreateRepeatCourseTaskConstructor
    
     init(type: TaskType, constructor: CreateRepeatCourseTaskConstructor, mode: CreateTaskMode,
          synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>)
    {
        self.constructor = constructor
        super.init(type: type, constructor: constructor.baseConstructor, mode: mode,
                   synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func getValidator() -> RitualTaskValidator {
        return RitualCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.construct()
    }
    
    override func validate(model: RepeatCreateTaskModel) -> Bool {
        let validator: RitualTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
    override func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let (fieldModel, _) = super.getCounterModel()
        let lockModel = LockButtonModel(isLocked: false)
        
        return (fieldModel, lockModel)
    }
    
}
