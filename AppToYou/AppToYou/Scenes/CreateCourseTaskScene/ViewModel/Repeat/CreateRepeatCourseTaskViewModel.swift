import Foundation
import XCoordinator


class CreateRepeatCourseTaskViewModel: CreateCourseTaskViewModel  {
    
    private let constructor: CreateRepeatCourseTaskConstructor
    private let repeatViewModel: CreateRepeatCourseTask
    
    init(type: ATYTaskType, constructor: CreateRepeatCourseTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        self.repeatViewModel = CreateRepeatCourseTask(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
        super.init(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
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
        prepare(model: constructor.repeatCourseTaskModel.repeatModel)
        save()
    }

    func validate(model: CreateRepeatCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = repeatViewModel.validate(model: model.repeatModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: RepeatCreateTaskModel) {
        super.prepare(model: model)
        
        if let isLocked = model.countModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
        let repeatCount = model.countModel.valueModel.value
        courseTaskRequest?.taskAttribute = "\(repeatCount)"
    }
    
}
