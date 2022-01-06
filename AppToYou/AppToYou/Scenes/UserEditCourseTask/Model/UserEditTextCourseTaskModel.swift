import Foundation


class UserEditTextCourseTaskModel: UserEditCourseTaskModel {
    
    let textModel = TextCreateTaskModel()
    
    override func getAdditionalModels() -> [AnyObject] {
        return textModel.getAdditionalModels()
    }
    
}
