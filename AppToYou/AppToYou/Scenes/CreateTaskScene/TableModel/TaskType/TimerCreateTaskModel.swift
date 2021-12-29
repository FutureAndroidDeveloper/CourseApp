import Foundation


class TimerCreateTaskModel: DefaultCreateTaskModel {
    var durationModel: TaskDurationCellModel!
    
    func addDurationHandler(duration: TaskDurationModel, lockModel: LockButtonModel?, timerCallback: @escaping () -> Void) {
        durationModel = TaskDurationCellModel(durationModel: duration, lockModel: lockModel, timerCallback: timerCallback)
    }
    
    override func getAdditionalModels() -> [AnyObject] {
        return [durationModel]
    }
}
