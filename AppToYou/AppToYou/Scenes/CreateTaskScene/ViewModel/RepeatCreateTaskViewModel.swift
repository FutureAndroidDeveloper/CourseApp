import Foundation
import XCoordinator


class RepeatCreateTaskViewModel: DefaultCreateTaskViewModel, CounterTaskCreationDelegate {
    
    private lazy var constructor: RepeatTaskModel = {
        return RepeatTaskModel(delegate: self)
    }()
    
    override func update() {
        data.value = constructor.getModels()
    }
    
    override func saveDidTapped() {
        super.saveDidTapped()
        
        let counter = constructor.model.countModel.valueModel.value
        print()
        print("Counter = \(counter)")
    }

    func getCounterModel() -> NaturalNumberFieldModel {
        // TODO: - получать повторения из модели задачи
        
        return NaturalNumberFieldModel()
    }
    
}
