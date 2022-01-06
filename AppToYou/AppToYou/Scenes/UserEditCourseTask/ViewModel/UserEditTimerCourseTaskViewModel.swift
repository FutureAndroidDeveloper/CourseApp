import Foundation
import XCoordinator


class UserEditTimerCourseTaskViewModel: UserEditCourseTaskViewModel, TimerTaskDataSource {
    
    private let constructor: UserEditTimerCourseTaskConstructor
    private let validator = TimerTaskValidator()
    
    init(userTask: UserTaskResponse, constructor: UserEditTimerCourseTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(userTask: userTask, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func userTaskdurationPicked(_ duration: DurationTime) {
        constructor.userEditTimerTaskModel.timerModel.durationModel.durationModel.update(durationTime: duration)
        update()
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setTimerDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.userEditTimerTaskModel) else {
            return
        }
        prepare(model: constructor.userEditTimerTaskModel)
        save()
    }

    func validate(model: TimerCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: UserEditTimerCourseTaskModel) {
        super.prepare(model: model)
        
        let duration = model.timerModel.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value
        let separator = Self.timeSeparator
        updateUserTaskRequest?.taskAttribute = "\(h)\(separator)\(m)\(separator)\(s)"
    }
    
    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?) {
        let attribute = userTask.taskAttribute ?? String()
        let hour = TimeBlockModelFactory.getHourModel()
        let min = TimeBlockModelFactory.getMinModel()
        let sec = TimeBlockModelFactory.getSecModel()

        attribute.split(separator: Self.timeSeparator)
            .enumerated()
            .forEach { item in
                let value = String(item.element)

                switch item.offset {
                case 0: hour.update(value: value)
                case 1: min.update(value: value)
                case 2: sec.update(value: value)
                default: break
                }
            }

        let duration = TaskDurationModel(hourModel: hour, minModel: min, secModel: sec)
        let lockModel = LockButtonModel(isLocked: userTask.editableCourseTask)
        return (duration, lockModel)
    }
    
}

