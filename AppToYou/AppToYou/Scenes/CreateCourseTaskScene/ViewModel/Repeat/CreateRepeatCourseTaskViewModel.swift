import Foundation
import XCoordinator


class CreateRepeatCourseTaskViewModel: CreateCourseTaskViewModel  {
    
    private let constructor: CreateRepeatCourseTaskConstructor
    private let repeatViewModel: CreateRepeatCourseTask
    
    init(courseId: Int, type: TaskType, constructor: CreateRepeatCourseTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        self.repeatViewModel = CreateRepeatCourseTask(
            type: type, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
        super.init(
            courseId: courseId, type: type, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
    }
    
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        repeatViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.repeatCourseTaskModel) else {
            return
        }
        prepare(model: constructor.repeatCourseTaskModel)
        save()
    }

    func validate(model: CreateRepeatCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = repeatViewModel.validate(model: model.repeatModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: CreateRepeatCourseTaskModel) {
        super.prepare(model: model)
        
        if let isLocked = model.repeatModel.countModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
        let repeatCount = model.repeatModel.countModel.valueModel.value
        courseTaskRequest?.taskAttribute = "\(repeatCount)"
    }
    
}
