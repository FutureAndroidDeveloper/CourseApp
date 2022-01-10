import Foundation
import XCoordinator


class CreateRepeatUserTaskViewModel: CreateUserTaskViewModel, CounterTaskDataSource {
    
    private let constructor: RepeatTaskConstructor
    private let validator = RitualTaskValidator()
    
    init(type: ATYTaskType, constructor: RepeatTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func getConstructor() -> RepeatTaskConstructor {
        return constructor
    }
    
    func getValidator() -> RitualTaskValidator {
        return validator
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.repeatModel) else {
            return
        }
        prepare(model: constructor.repeatModel)
        save()
    }

    func validate(model: RepeatCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: RepeatCreateTaskModel) {
        super.prepare(model: model)
        
        let repeatCount = model.countModel.valueModel.value
        userTaskRequest?.taskAttribute = "\(repeatCount)"
    }
    
    override func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }

    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        return (NaturalNumberFieldModel(), nil)
    }
    
}
