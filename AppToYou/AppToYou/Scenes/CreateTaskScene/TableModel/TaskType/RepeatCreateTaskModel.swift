import Foundation


class RepeatCreateTaskModel: DefaultCreateTaskModel {
    var countModel: CreateCountRepeatTaskCellModel!
    
    func addCountHandler() {
        countModel = CreateCountRepeatTaskCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [countModel]
    }
}
