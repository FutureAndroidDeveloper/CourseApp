import Foundation


class TimerCreateTaskModel: DefaultCreateTaskModel {
    var durationModel: CreateDurationTaskCellModel!
    
    func addDurationHandler() {
        durationModel = CreateDurationTaskCellModel()
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [durationModel]
    }
}
