import Foundation
import XCoordinator


class AdminEditTimerCourseTaskViewModel: AdminEditCourseTaskViewModel, TimerTaskDataSource {
    private let constructor: AdminEditTimerCourseTaskConstructor
    private let repeatViewModel: AdminEditTimerCourseTask
    
    
    init(courseName: String, courseTask: CourseTaskResponse,
         constructor: AdminEditTimerCourseTaskConstructor,
         mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.constructor = constructor
        self.repeatViewModel = AdminEditTimerCourseTask(type: courseTask.taskType, constructor: constructor,
                                                         mode: mode, taskRouter: taskRouter)
        super.init(courseName: courseName, courseTask: courseTask, constructor: constructor,
                   mode: mode, taskRouter: taskRouter)
    }
    
    override func userTaskdurationPicked(_ duration: DurationTime) {
        constructor.timerCourseTaskModel.timerModel.durationModel.durationModel.update(durationTime: duration)
        update()
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        repeatViewModel.setDataSource(dataSource: self)
        repeatViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.timerCourseTaskModel) else {
            return
        }
        prepare(model: constructor.timerCourseTaskModel)
        save()
    }

    func validate(model: AdminEditTimerCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = repeatViewModel.validate(model: model.timerModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: AdminEditTimerCourseTaskModel) {
        super.prepare(model: model)
        
        if let isLocked = model.timerModel.durationModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
        let duration = model.timerModel.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value
        let separator = Self.timeSeparator
        courseTaskRequest?.taskAttribute = "\(h)\(separator)\(m)\(separator)\(s)"
    }
    
    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?) {
        let attribute = courseTask.taskAttribute ?? String()
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
        let editable = courseTask.editable ?? true
        let lockModel = LockButtonModel(isLocked: !editable)
        return (duration, lockModel)
    }
    
}
