import Foundation


class TimerCreateTaskModel: DefaultCreateTaskModel {
    var durationModel: TaskDurationCellModel!
    
    func addDurationHandler(duration: TaskDurationModel, timerCallback: @escaping () -> Void) {
        durationModel = TaskDurationCellModel(durationModel: duration, timerCallback: timerCallback)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [durationModel]
    }
}
