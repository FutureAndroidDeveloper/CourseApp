import Foundation


class TimerCourseTaskValidator: TimerTaskValidator {
    override func validate(model: TimerCreateTaskModel) {
        validate(durationField: model.durationModel)
    }
    
}
