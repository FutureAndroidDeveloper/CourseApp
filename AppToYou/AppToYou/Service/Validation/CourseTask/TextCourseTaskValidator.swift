import Foundation


class TextCourseTaskValidator: TextTaskValidator {
    override func validate(model: TextCreateTaskModel) {
        validate(descriptionField: model.descriptionModel)
        validate(symbolsField: model.lengthLimitModel)
    }
    
}
