import Foundation


enum CourseTaskError: ValidationError {
    case minSanction
    case coureTaskDuration(common: CommonValidationError.Duration)
    
    var message: String? {
        switch self {
        case .minSanction:
            return "Укажите минимальный штраф за невыполнение"
        case .coureTaskDuration(let common):
            return common.message
        }
    }
}


class CreateCourseTaskValidator: CheckboxTaskValidator<CreateCourseTaskModel> {
    
    override func validate(model: CreateCourseTaskModel) {
        super.validate(model: model)
        
        validate(minSanctionField: model.minSanctionModel, sanctionField: model.sanctionModel)
        validate(courseTaskdurationField: model.courseTaskDurationModel)
    }
    
    func bind(error: CourseTaskError?, to receiver: ValidationErrorDisplayable) {
        super.updateErrorState(new: error)
        
        if case let .coureTaskDuration(commonError) = error {
            receiver.bind(error: commonError)
        } else {
            receiver.bind(error: error)
        }
    }
    
    private func validate(minSanctionField: CourseTaskMinSanctionModel?, sanctionField: TaskSanctionModel) {
        guard let field = minSanctionField else {
            return
        }
        
        if field.fieldModel.value == .zero, field.isActive {
            sanctionField.updateMinValue(.zero)
            bind(error: .minSanction, to: field)
        } else {
            sanctionField.updateMinValue(field.fieldModel.value)
            super.bind(error: nil, to: field)
        }
    }
    
    private func validate(courseTaskdurationField: CourseTaskDurationModel?) {
        guard let field = courseTaskdurationField else {
            return
        }
        
        if field.isInfiniteModel.isSelected {
            super.bind(error: nil, to: field)
        } else if field.durationModel.isDefault {
            bind(error: .coureTaskDuration(common: .duration), to: field)
        } else {
            super.bind(error: nil, to: field)
        }
    }
    
}
