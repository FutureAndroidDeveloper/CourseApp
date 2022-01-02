import Foundation


/**
 Модель текстовой задачи для создания курсовой задачи.
 */
class CreateTextCourseTaskModel: CreateCourseTaskModel {
    
    let textModel = TextCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return textModel.getAdditionalModels()
    }
    
}
