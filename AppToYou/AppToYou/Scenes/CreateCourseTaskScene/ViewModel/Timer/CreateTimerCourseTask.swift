import Foundation
import XCoordinator


/**
 Класс, который переопределяет поведение поля длительности выполнения задачи для создания курсовой задачи.
 */
class CreateTimerCourseTask: CreateTimerUserTaskViewModel {
    
    private let constructor: CreateTimerCourseTaskConstructor
    
     init(type: TaskType, constructor: CreateTimerCourseTaskConstructor, mode: CreateTaskMode,
          synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>)
    {
        self.constructor = constructor
        super.init(type: type, constructor: constructor.baseConstructor, mode: mode,
                   synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func userTaskdurationPicked(_ duration: DurationTime) {
        constructor.timerCourseTaskModel.timerModel.durationModel.durationModel.update(durationTime: duration)
    }
    
    override func getValidator() -> TimerTaskValidator {
        return TimerCourseTaskValidator()
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.construct()
    }
    
    override func validate(model: TimerCreateTaskModel) -> Bool {
        let validator: TimerTaskValidator = getValidator()
        validator.validate(model: model)

        return !validator.hasError
    }
    
    override func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?) {
        let (fieldModel, _) = super.getDurationModel()
        let lockModel = LockButtonModel(isLocked: false)
        
        return (fieldModel, lockModel)
    }
    
}
