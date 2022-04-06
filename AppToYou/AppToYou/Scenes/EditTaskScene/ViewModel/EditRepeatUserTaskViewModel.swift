import Foundation
import XCoordinator


class EditRepeatUserTaskViewModel: EditUserTaskViewModel, CounterTaskDataSource {
    
    private let constructor: RepeatTaskConstructor
    private let validator = RitualTaskValidator()
    
    init(task: Task, constructor: RepeatTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(task: task, constructor: constructor, mode: mode, synchronizationService: synchronizationService, taskRouter: taskRouter)
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
        updatedTask.taskAttribute = "\(repeatCount)"
    }
    
    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = task.taskAttribute ?? String()
        let value = Int(attribute) ?? 0
        let model = NaturalNumberFieldModel(value: value)
        
        return (model, nil)
    }
    
}
