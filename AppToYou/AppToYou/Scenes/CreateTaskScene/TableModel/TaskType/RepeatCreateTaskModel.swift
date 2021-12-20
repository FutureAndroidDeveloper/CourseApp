import Foundation


class RepeatCreateTaskModel: DefaultCreateTaskModel {
    var countModel: RepeatCounterModel!
    
    func addCounter(model: NaturalNumberFieldModel) {
        countModel = RepeatCounterModel(valueModel: model)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}
