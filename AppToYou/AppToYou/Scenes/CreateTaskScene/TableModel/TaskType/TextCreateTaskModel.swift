import Foundation


class TextCreateTaskModel: DefaultCreateTaskModel {
    var descriptionModel: DescriptionModel!
    var lengthLimitModel: NaturalNumberFieldModel!
    
    func addDescriptionHandler(model: PlaceholderTextViewModel) {
        descriptionModel = DescriptionModel(fieldModel: model)
    }
    
    func addLimitHandler(model: NaturalNumberFieldModel) {
        lengthLimitModel = model
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
