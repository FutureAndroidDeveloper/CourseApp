import Foundation
import XCoordinator


class TextCreateTaskViewModel: DefaultCreateTaskViewModel, TextTaskCreationDelegate {

    private lazy var constructor: TextTaskModel = {
        return TextTaskModel(delegate: self)
    }()
    
    override func update() {
        data.value = constructor.getModels()
    }
    
//    override func saveDidTapped() {
//        super.saveDidTapped()
//    }
    
    override func makeModel() {
        super.makeModel()
        
        let description = constructor.model.descriptionModel.fieldModel.value
        let min = constructor.model.lengthLimitModel.value
        print()
        print("text = \(description)")
        print("limit = \(min)")
        
        taskRequest?.taskDescription = description
        taskRequest?.taskAttribute = "\(min)"
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
