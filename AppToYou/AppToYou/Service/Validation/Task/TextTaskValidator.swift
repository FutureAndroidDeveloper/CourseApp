import Foundation

enum TextTaskError: ValidationError {
    case description(common: CommonValidationError.Description)
    case minSymbols
    case long
    
    var message: String? {
        switch self {
        case .description(let common):
            return common.message
        case .long:
            return "Слишком большое количество символом"
        case .minSymbols:
            return "Укажите минимальное количество символом"
        }
    }
}


class TextTaskValidator: CheckboxTaskValidator<TextCreateTaskModel> {
    override func validate(model: TextCreateTaskModel) {
        super.validate(model: model)
        
        validate(descriptionField: model.descriptionModel)
        validate(symbolsField: model.lengthLimitModel)
    }
    
    func bind(error: TextTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        
        if case let .description(commonError) = error {
            receiver.bind(error: commonError)
        } else {
            receiver.bind(error: error)
        }
    }
    
    func validate(descriptionField: DescriptionModel) {
        if let description = descriptionField.fieldModel.value, description.count > 255 {
            bind(error: .description(common: .descriptionLength), to: descriptionField)
        } else {
            super.bind(error: nil, to: descriptionField)
        }
    }
    
    func validate(symbolsField: MinimumSymbolsModel) {
        let symbolsCount = symbolsField.fieldModel.value
        
        if symbolsCount == .zero {
            bind(error: .minSymbols, to: symbolsField)
        } else if symbolsCount > Int32.max {
            bind(error: .long, to: symbolsField)
        } else {
            super.bind(error: nil, to: symbolsField)
        }
    }
    
}
