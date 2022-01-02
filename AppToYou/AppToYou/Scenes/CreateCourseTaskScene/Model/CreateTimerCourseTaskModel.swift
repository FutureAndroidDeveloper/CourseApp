import Foundation


/**
 Модель длительности выполнения задачи для создания курсовой задачи.
 */
class CreateTimerCourseTaskModel: CreateCourseTaskModel {
    
    let timerModel = TimerCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return timerModel.getAdditionalModels()
    }
    
}
