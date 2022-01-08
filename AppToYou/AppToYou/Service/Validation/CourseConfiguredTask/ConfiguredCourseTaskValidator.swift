import Foundation


enum ConfiguredCourseTaskError: ValidationError {
    case sanction(common: CommonValidationError.Sanction)
    
    var message: String? {
        switch self {
        case .sanction(let common):
            return common.message
        }
    }
}


class ConfiguredCourseTaskValidator: Validating {
    var hasError: Bool
    
    private let ritualValidator = RitualCourseTaskValidator()
    private let timerValidator = TimerCourseTaskValidator()
    private let textValidator = TextCourseTaskValidator()
    
    init() {
        hasError = false
    }
    
    func bind(error: ConfiguredCourseTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        
        if case let .sanction(commonError) = error {
            receiver.bind(error: commonError)
        }
        else {
            receiver.bind(error: error)
        }
    }
    
    func updateErrorState(new error: ValidationError?) {
        let isFieldHasError = error == nil ? false : true
        let validatorsResult = ritualValidator.hasError || timerValidator.hasError || textValidator.hasError
        hasError = isFieldHasError || validatorsResult
    }
    
    func validate(model: AddCourseTaskModel) {
        if let repeatModel = model.fieldModel as? RepeatCounterModel {
            ritualValidator.validate(counterField: repeatModel)
        }
        
        if let timerModel = model.fieldModel as? TaskDurationCellModel {
            timerValidator.validate(durationField: timerModel)
        }
        
        if let symbolsModel = model.fieldModel as? MinimumSymbolsModel {
            textValidator.validate(symbolsField: symbolsModel)
        }
        validate(sanctionField: model.sanctionModel)
    }
    
    private func validate(sanctionField: TaskSanctionModel?) {
        guard let field = sanctionField else {
            return
        }
        let value = field.fieldModel.value
        
        if field.isEnabled, value < field.minValue {
            bind(error: .sanction(common: .lessThanMin(value: field.minValue)), to: field)
        } else if field.isEnabled, value == .zero {
            bind(error: .sanction(common: .sanction), to: field)
        } else {
            bind(error: nil, to: field)
        }
    }
    
}
