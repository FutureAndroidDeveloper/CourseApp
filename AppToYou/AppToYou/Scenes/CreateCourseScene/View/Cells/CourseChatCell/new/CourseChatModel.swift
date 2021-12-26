import Foundation


class CourseChatModel: ValidatableModel {
    
    let fieldModel: TextFieldModel
    var errorNotification: ((CourseError?) -> Void)?
    
    init(fieldModel: TextFieldModel) {
        self.fieldModel = fieldModel
    }
    
}
