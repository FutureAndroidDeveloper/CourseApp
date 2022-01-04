import Foundation


class AdminEditRepeatCourseTaskModel: AdminEditCourseTaskModel {
    let repeatModel = RepeatCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return repeatModel.getAdditionalModels()
    }
}
