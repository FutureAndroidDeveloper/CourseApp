import Foundation
import XCoordinator


class CreateTextUserTaskViewModel: CreateUserTaskViewModel, TextTaskDataSource {
    
    private let constructor: TextTaskConstructor
    private let validator = TextTaskValidator()
    
    init(type: ATYTaskType, constructor: TextTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func getConstructor() -> TextTaskConstructor {
        return constructor
    }
    
    func getValidator() -> TextTaskValidator {
        return validator
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
        userTaskRequest?.taskDescription = description
        userTaskRequest?.taskAttribute = "\(minSymbols)"
    }
    
    override func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        return PlaceholderTextViewModel(value: nil, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let model = NaturalNumberFieldModel()
        return (model, nil)
    }
    
}
