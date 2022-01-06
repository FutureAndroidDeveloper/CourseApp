import Foundation
import XCoordinator


class UserEditRepeatCourseTaskViewModel: UserEditCourseTaskViewModel, CounterTaskDataSource {
    
    private let constructor: UserEditRepeatCourseTaskConstructor
    private let validator = RitualTaskValidator()
    
    init(userTask: UserTaskResponse, constructor: UserEditRepeatCourseTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(userTask: userTask, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setRepeatDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.userEditRepeatTaskModel) else {
            return
        }
        prepare(model: constructor.userEditRepeatTaskModel)
        save()
    }

    func validate(model: RepeatCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: UserEditRepeatCourseTaskModel) {
        super.prepare(model: model)
        let repeatCount = model.repeatModel.countModel.valueModel.value
        updateUserTaskRequest?.taskAttribute = "\(repeatCount)"
    }
    
    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = userTask.taskAttribute ?? String()
        let value = Int(attribute) ?? 0
        let model = NaturalNumberFieldModel(value: value)
        
        let lockModel = LockButtonModel(isLocked: userTask.editableCourseTask)
        
        return (model, lockModel)
    }
    
}

