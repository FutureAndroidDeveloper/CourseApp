import Foundation


class TextCreateTaskModel: DefaultCreateTaskModel {
    var descriptionModel: PlaceholderTextViewModel!
    var lengthLimitModel: NaturalNumberFieldModel!
    
    func addDescriptionHandler(model: PlaceholderTextViewModel) {
        descriptionModel = model
    }
    
    func addLimitHandler(model: NaturalNumberFieldModel) {
        lengthLimitModel = model
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
