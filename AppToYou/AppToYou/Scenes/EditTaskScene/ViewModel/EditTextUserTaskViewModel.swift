
import Foundation
import XCoordinator


class EditTextUserTaskViewModel: EditUserTaskViewModel, TextTaskDataSource {
    
    private let constructor: TextTaskConstructor
    private let validator = TextTaskValidator()
    
    init(task: Task, constructor: TextTaskConstructor, mode: CreateTaskMode,
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
        guard validate(model: constructor.textModel) else {
            return
        }
        prepare(model: constructor.textModel)
        save()
    }

    func validate(model: TextCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: TextCreateTaskModel) {
        super.prepare(model: model)
        
        let description = model.descriptionModel.fieldModel.value
        let minSymbols = model.lengthLimitModel.fieldModel.value
        updatedTask.taskDescription = description
        updatedTask.taskAttribute = "\(minSymbols)"
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        let description = task.taskDescription
        return PlaceholderTextViewModel(value: description, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = task.taskAttribute ?? String()
        let minSymbols = Int(attribute) ?? 0
        let model = NaturalNumberFieldModel(value: minSymbols)
        
        return (model, nil)
    }
}
