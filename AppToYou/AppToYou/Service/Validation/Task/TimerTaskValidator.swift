import Foundation


enum TimerTaskError: ValidationError {
    case duration
    
    var message: String? {
        switch self {
        case .duration:
            return "Установите значение"
        }
    }
}


class TimerTaskValidator: CheckboxTaskValidator<TimerCreateTaskModel> {
    override func validate(model: TimerCreateTaskModel) {
        super.validate(model: model)
        
        validate(durationField: model.durationModel)
    }
    
    func bind(error: TimerTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        receiver.bind(error: error)
    }
    
    private func validate(durationField: TaskDurationCellModel) {
        let duration = durationField.durationModel
        
        if duration.isDefault {
            bind(error: .duration, to: durationField)
        } else {
            super.bind(error: nil, to: durationField)
        }
    }
    
}
