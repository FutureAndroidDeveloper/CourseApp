import Foundation


enum CheckboxTaskError: ValidationError {
    case name(common: CommonValidationError.Name)
    case weekdays
    case startDate
    case endDate
    case emptyEndDate
    case notifications
    case sanction
    case lessThanMin(value: Int)
//    case minSanction
//    case coureTaskDuration(common: CommonValidationError.Duration)
    
    var message: String? {
        switch self {
        case .name(let common):
            return common.message
        case .weekdays:
            return "Выберите дни недели"
        case .startDate:
            return "Дата начала не должна быть меньше текущей"
        case .endDate:
            return "Дата конца должна быть больше даты начала"
        case .emptyEndDate:
            return "Выберите дату"
        case .notifications:
            return "Установите напоминания или откючите поле"
        case .sanction:
            return "Введите штраф за невыполнение или откючите поле"
        case .lessThanMin(let value):
            return "Штраф не может быть меньше \(value)"
//        case .minSanction:
//            return "Укажите минимальный штраф за невыполнение"
//        case .coureTaskDuration(let common):
//            return common.message
        }
    }
}


class CheckboxTaskValidator<Model>: Validating where Model: DefaultCreateTaskModel {
    
    var hasError: Bool
    
    init() {
        hasError = false
    }
    
    func validate(model: Model) {
        hasError = false
        
        validate(nameField: model.nameModel)
        validate(frequencyField: model.frequencyModel)
        validate(selectDateField: model.selectDateModel)
        validate(weekdayField: model.weekdayModel)
        validate(periodField: model.periodModel)
        validete(notificationField: model.notificationModel)
//        validate(minSanctionField: model.minSanctionModel, sanctionField: model.sanctionModel)
        validate(sanctionField: model.sanctionModel)
//        validate(courseTaskdurationField: model.courseTaskDurationModel)
    }
    
    func bind(error: CheckboxTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        
        if case let .name(commonError) = error {
            receiver.bind(error: commonError)
        }
        else {
            receiver.bind(error: error)
        }
    }
    
    func updateErrorState(new error: ValidationError?) {
        let isFiledHasError = error == nil ? false : true
        hasError = hasError || isFiledHasError
    }
    
    private func validate(nameField: TaskNameModel) {
        let name = nameField.fieldModel.value
        
        if name.isEmpty {
            bind(error: .name(common: .name), to: nameField)
        } else if name.count > 63 {
            bind(error: .name(common: .nameLength), to: nameField)
        } else {
            bind(error: nil, to: nameField)
        }
    }
    
    private func validate(frequencyField: FrequencyModel) {
        // pass
    }
    
    private func validete(notificationField: NotificationAboutTaskModel) {
        let notifications = notificationField.notificationModels
        
        if let first = notifications.first, first.isDefault, notificationField.isEnabled {
            bind(error: .notifications, to: notificationField)
        } else {
            bind(error: nil, to: notificationField)
        }
    }
    
    private func validate(sanctionField: TaskSanctionModel) {
        let value = sanctionField.fieldModel.value
        
        if sanctionField.isEnabled, value < sanctionField.minValue {
            bind(error: .lessThanMin(value: sanctionField.minValue), to: sanctionField)
        } else if sanctionField.isEnabled, value == .zero {
            bind(error: .sanction, to: sanctionField)
        } else {
            bind(error: nil, to: sanctionField)
        }
    }
    
    private func validate(weekdayField: SelectWeekdayModel?) {
        guard let field = weekdayField else {
            return
        }
        let selectedModels = field.weekdayModels.filter { $0.isSelected }
        
        if selectedModels.isEmpty {
            bind(error: .weekdays, to: field)
        } else {
            bind(error: nil, to: field)
        }
    }
    
    private func validate(selectDateField: SelectDateModel?) {
        guard let field = selectDateField else {
            return
        }
        
        if let date = field.date.value, Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedAscending {
            bind(error: .startDate, to: field)
        } else {
            bind(error: nil, to: field)
        }
    }
    
    private func validate(periodField: TaskPeriodModel?) {
        guard
            let field = periodField,
            let start = field.start.value
        else {
            return
        }
        var error: CheckboxTaskError?
        
        if let end = field.end.value, !field.isInfiniteModel.isSelected {
            if !(Calendar.current.compare(end, to: start, toGranularity: .day) == .orderedDescending) {
                error = .endDate
            }
        }
        
        if field.end.value == nil, !field.isInfiniteModel.isSelected {
            error = .emptyEndDate
        }
        
        if Calendar.current.compare(start, to: Date(), toGranularity: .day) == .orderedAscending {
            error = .startDate
        }
        
        bind(error: error, to: field)
    }
    
//    private func validate(minSanctionField: CourseTaskMinSanctionModel?, sanctionField: TaskSanctionModel) {
//        guard let field = minSanctionField else {
//            return
//        }
//        
//        if field.fieldModel.value == .zero, field.isActive {
//            sanctionField.updateMinValue(.zero)
//            bind(error: .minSanction, to: field)
//        } else {
//            sanctionField.updateMinValue(field.fieldModel.value)
//            bind(error: nil, to: field)
//        }
//    }
//    
//    private func validate(courseTaskdurationField: CourseTaskDurationModel?) {
//        guard let field = courseTaskdurationField else {
//            return
//        }
//        
//        if field.isInfiniteModel.isSelected {
//            bind(error: nil, to: field)
//        } else if field.durationModel.isDefault {
//            bind(error: .coureTaskDuration(common: .duration), to: field)
//        } else {
//            bind(error: nil, to: field)
//        }
//    }
    
}
