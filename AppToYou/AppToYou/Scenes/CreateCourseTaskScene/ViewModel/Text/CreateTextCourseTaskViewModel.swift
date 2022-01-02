import Foundation
import XCoordinator


class CreateTextCourseTaskViewModel: CreateCourseTaskViewModel  {
    
    private let constructor: CreateTextCourseTaskConstructor
    private let timerViewModel: CreateTextCourseTask
    
    init(type: ATYTaskType, constructor: CreateTextCourseTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        self.timerViewModel = CreateTextCourseTask(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
        super.init(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        timerViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.textCourseTaskModel) else {
            return
        }
        prepare(model: constructor.textCourseTaskModel.textModel)
        save()
    }

    func validate(model: CreateTextCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = timerViewModel.validate(model: model.textModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: CreateTextCourseTaskModel) {
        super.prepare(model: model)
        
        let description = model.textModel.descriptionModel.fieldModel.value
        let minSymbols = model.textModel.lengthLimitModel.fieldModel.value
        courseTaskRequest?.taskDescription = description
        courseTaskRequest?.taskAttribute = "\(minSymbols)"
        
        if let isLocked = model.textModel.lengthLimitModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
    }
    
}
