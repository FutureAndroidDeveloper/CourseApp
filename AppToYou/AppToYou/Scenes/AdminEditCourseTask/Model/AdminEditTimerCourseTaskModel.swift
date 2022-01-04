import Foundation


class AdminEditTimerCourseTaskModel: AdminEditCourseTaskModel {
    let timerModel = TimerCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return timerModel.getAdditionalModels()
    }
}
