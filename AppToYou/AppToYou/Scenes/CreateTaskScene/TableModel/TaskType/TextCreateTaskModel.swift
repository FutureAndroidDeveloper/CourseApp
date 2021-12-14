import Foundation


class TextCreateTaskModel: DefaultCreateTaskModel {
    var descriptionModel: PlaceholderTextViewModel!
    var lengthLimitModel: CreateMaxCountSymbolsCellModel!
    
    func addDescriptionHandler(model: PlaceholderTextViewModel) {
        descriptionModel = model
    }
    
    func addLimitHandler() {
        lengthLimitModel = CreateMaxCountSymbolsCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
