import Foundation


class RepeatCreateTaskModel: DefaultCreateTaskModel {
    var countModel: RepeatCounterModel!
    
    func addCounter(model: NaturalNumberFieldModel, lockModel: LockButtonModel?) {
        countModel = RepeatCounterModel(valueModel: model, lockModel: lockModel)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}
