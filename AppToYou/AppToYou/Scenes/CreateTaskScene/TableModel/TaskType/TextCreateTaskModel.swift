import Foundation


class TextCreateTaskModel: DefaultCreateTaskModel {
    var descriptionModel: CreateDescriptionTaskCellModel!
    var lengthLimitModel: CreateMaxCountSymbolsCellModel!
    
    func addDescriptionHandler(_ handler: @escaping (String) -> Void) {
        descriptionModel = CreateDescriptionTaskCellModel(descriptionEntered: handler)
    }
    
    func addLimitHandler() {
        lengthLimitModel = CreateMaxCountSymbolsCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [descriptionModel, lengthLimitModel]
    }
}
