import Foundation


enum TimerTaskError: ValidationError {
    case duration(common: CommonValidationError.Duration)
    
    var message: String? {
        switch self {
        case .duration(let common):
            return common.message
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
        
        if case let .duration(commonError) = error {
            receiver.bind(error: commonError)
        } else {
            receiver.bind(error: error)
        }
    }
    
    func validate(durationField: TaskDurationCellModel) {
        let duration = durationField.durationModel
        
        if duration.isDefault {
            bind(error: .duration(common: .duration), to: durationField)
        } else {
            super.bind(error: nil, to: durationField)
        }
    }
    
}
