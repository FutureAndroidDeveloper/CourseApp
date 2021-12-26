import Foundation
import XCoordinator


class RepeatCreateTaskViewModel: DefaultCreateTaskViewModel<RepeatCreateTaskModel>, CounterTaskCreationDelegate {
    
    private lazy var constructor: RepeatTaskModel = {
        return RepeatTaskModel(delegate: self)
    }()
    
    private let validator = RitualTaskValidator()
    
    
    override func saveDidTapped() {
        guard validate(model: constructor.model) else {
            return
        }
        save()
    }
    
    override func validate(model: RepeatCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        
        validator.validate(model: model)
        if !validator.hasError {
            prepare(model: model)
        }
        return !validator.hasError && baseValidationResult
    }
    
    override func prepare(model: RepeatCreateTaskModel) {
        super.prepare(model: model)
        
        let repeatCount = constructor.model.countModel.valueModel.value
        taskRequest?.taskAttribute = "\(repeatCount)"
    }

    override func update() {
        data.value = constructor.getModels()
    }
    
    func getCounterModel() -> NaturalNumberFieldModel {
        // TODO: - получать повторения из модели задачи
        
        return NaturalNumberFieldModel()
    }
    
}
