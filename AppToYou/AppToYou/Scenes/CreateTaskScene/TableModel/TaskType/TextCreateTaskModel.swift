import Foundation


class TextCreateTaskModel: DefaultCreateTaskModel {
    var descriptionModel: DescriptionModel!
    var lengthLimitModel: MinimumSymbolsModel!
    
    func addDescriptionHandler(model: PlaceholderTextViewModel) {
        descriptionModel = DescriptionModel(fieldModel: model)
    }
    
    func addLimitHandler(model: NaturalNumberFieldModel) {
        lengthLimitModel = MinimumSymbolsModel(fieldModel: model)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
