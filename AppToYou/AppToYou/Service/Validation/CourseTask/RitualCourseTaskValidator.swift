import Foundation


class RitualCourseTaskValidator: RitualTaskValidator {
    override func validate(model: RepeatCreateTaskModel) {
        validate(counterField: model.countModel)
    }
    
}
