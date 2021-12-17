import Foundation


class RepeatCreateTaskModel: DefaultCreateTaskModel {
    var countModel: RepeatCounterModel!
    
    func addCountHandler() {
        let model = NaturalNumberFieldModel()
        countModel = RepeatCounterModel(valueModel: model)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}
