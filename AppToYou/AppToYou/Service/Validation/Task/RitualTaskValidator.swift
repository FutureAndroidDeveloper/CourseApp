import Foundation


enum RitualTaskError: ValidationError {
    case toMuch
    case zero
    
    var message: String? {
        switch self {
        case .toMuch:
            return "To much"
        case .zero:
            return "Не ноль"
        }
    }
}


class RitualTaskValidator: CheckboxTaskValidator<RepeatCreateTaskModel> {
    override func validate(model: RepeatCreateTaskModel) {
        super.validate(model: model)
        
        validate(counterField: model.countModel)
    }
    
    func bind(error: RitualTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        receiver.bind(error: error)
    }
    
    func validate(counterField: RepeatCounterModel) {
        let count = counterField.valueModel.value
        
        if count == .zero {
            bind(error: .zero, to: counterField)
        }
        else if count > Int32.max {
            bind(error: .toMuch, to: counterField)
        }
        else {
            super.bind(error: nil, to: counterField)
        }
    }
    
}
