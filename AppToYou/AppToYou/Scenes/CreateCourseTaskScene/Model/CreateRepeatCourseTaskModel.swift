import Foundation


/**
 Модель счетчика повторений для создания курсовой задачи.
 */
class CreateRepeatCourseTaskModel: CreateCourseTaskModel {
    
    let repeatModel = RepeatCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return repeatModel.getAdditionalModels()
    }
    
}
