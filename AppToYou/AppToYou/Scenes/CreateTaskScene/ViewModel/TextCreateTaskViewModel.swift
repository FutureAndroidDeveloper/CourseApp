import Foundation
import XCoordinator


class TextCreateTaskViewModel: DefaultCreateTaskViewModel<TextCreateTaskModel>, TextTaskCreationDelegate {

    private lazy var constructor: TextTaskModel = {
        return TextTaskModel(delegate: self)
    }()
    
    private let validator = TextTaskValidator()
    
    
    override func saveDidTapped() {
        guard validate(model: constructor.model) else {
            return
        }
        save()
    }
    
    override func validate(model: TextCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        
        validator.validate(model: model)
        if !validator.hasError {
            prepare(model: model)
        }
        return !validator.hasError && baseValidationResult
    }
    
    override func prepare(model: TextCreateTaskModel) {
        super.prepare(model: model)
        
        let description = constructor.model.descriptionModel.fieldModel.value
        let minSymbols = constructor.model.lengthLimitModel.fieldModel.value
        taskRequest?.taskDescription = description
        taskRequest?.taskAttribute = "\(minSymbols)"
    }
    
    override func update() {
        data.value = constructor.getModels()
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        // TODO: - получать описание из модели задачи
        
        return PlaceholderTextViewModel(value: nil, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> NaturalNumberFieldModel {
        // TODO: - получать кол-во из модели задачи
        
        return NaturalNumberFieldModel()
    }
    
}
