import Foundation
import XCoordinator


class CreateTimerUserTaskViewModel: CreateUserTaskViewModel, TimerTaskDataSource {
    
    private let constructor: TimerTaskConstructor
    private let validator = TimerTaskValidator()
    
    init(type: TaskType, constructor: TimerTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(type: type, constructor: constructor, mode: mode, synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func getConstructor() -> TimerTaskConstructor {
        return constructor
    }
    
    func getValidator() -> TimerTaskValidator {
        return validator
    }
    
    override func userTaskdurationPicked(_ duration: DurationTime) {
        constructor.timerModel.durationModel.durationModel.update(durationTime: duration)
        update()
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.timerModel) else {
            return
        }
        prepare(model: constructor.timerModel)
        save()
    }

    func validate(model: TimerCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: TimerCreateTaskModel) {
        super.prepare(model: model)
        
        let duration = model.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value
        let separator = Self.timeSeparator
        
        task.taskAttribute = "\(h)\(separator)\(m)\(separator)\(s)"
    }
    
    override func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }

    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?) {
        let hour = TimeBlockModelFactory.getHourModel()
        let min = TimeBlockModelFactory.getMinModel()
        let sec = TimeBlockModelFactory.getSecModel()
        let duration = TaskDurationModel(hourModel: hour, minModel: min, secModel: sec)
        
        return (duration, nil)
    }
    
}
