import Foundation
import XCoordinator


class CreateTimerCourseTaskViewModel: CreateCourseTaskViewModel  {
    
    private let constructor: CreateTimerCourseTaskConstructor
    private let timerViewModel: CreateTimerCourseTask
    
    init(courseId: Int, type: TaskType, constructor: CreateTimerCourseTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        self.timerViewModel = CreateTimerCourseTask(
            type: type, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
        super.init(
            courseId: courseId, type: type, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
    }
    
    override func userTaskdurationPicked(_ duration: DurationTime) {
        constructor.timerCourseTaskModel.timerModel.durationModel.durationModel.update(durationTime: duration)
        update()
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        timerViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.timerCourseTaskModel) else {
            return
        }
        prepare(model: constructor.timerCourseTaskModel)
        save()
    }

    func validate(model: CreateTimerCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = timerViewModel.validate(model: model.timerModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: CreateTimerCourseTaskModel) {
        super.prepare(model: model)
        
        let duration = model.timerModel.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value
        let separator = Self.timeSeparator
        courseTaskRequest?.taskAttribute = "\(h)\(separator)\(m)\(separator)\(s)"
        
        if let isLocked = model.timerModel.durationModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
    }
    
}
