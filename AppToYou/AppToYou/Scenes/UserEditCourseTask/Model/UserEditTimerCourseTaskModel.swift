import Foundation


class UserEditTimerCourseTaskModel: UserEditCourseTaskModel {
    
    let timerModel = TimerCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return timerModel.getAdditionalModels()
    }
    
}
