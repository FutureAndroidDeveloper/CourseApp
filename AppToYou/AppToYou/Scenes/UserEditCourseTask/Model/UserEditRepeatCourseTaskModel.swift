import Foundation


class UserEditRepeatCourseTaskModel: UserEditCourseTaskModel {
    
    let repeatModel = RepeatCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return repeatModel.getAdditionalModels()
    }
    
}
