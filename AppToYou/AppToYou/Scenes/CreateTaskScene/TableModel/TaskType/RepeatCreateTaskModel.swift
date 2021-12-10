import Foundation


class RepeatCreateTaskModel: DefaultCreateTaskModel {
    var countModel: CreateCountRepeatTaskCellModel!
    
    func addCountHandler() {
        let model = NaturalNumberFieldModel()
        countModel = CreateCountRepeatTaskCellModel(valueModel: model)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}
