import Foundation


class AdminEditTextCourseTaskModel: AdminEditCourseTaskModel {
    let textModel = TextCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return textModel.getAdditionalModels()
    }
}
