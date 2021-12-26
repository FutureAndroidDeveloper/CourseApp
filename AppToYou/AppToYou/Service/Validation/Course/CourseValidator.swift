import Foundation


class CourseValidator: Validating {
    
    var hasError: Bool
    
    init() {
        hasError = false
    }
    
    func validate(model: CreateCourseModel) {
        hasError = false
        
        validate(nameField: model.nameModel)
        validate(descriptionField: model.descriptionModel)
        validate(categoriesField: model.categoryModel)
        validate(paymentField: model.payModel)
        validate(durationField: model.durationModel)
        validate(chatField: model.chatModel)
    }
    
    func bind(error: CourseError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        
        guard let error = error else {
            receiver.bind(error: nil)
            return
        }
        
        switch error {
        case .name(let common):
            receiver.bind(error: common)
        case .description(let common):
            receiver.bind(error: common)
        case .duration(let common):
            receiver.bind(error: common)
        default:
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
    
    private func validate(descriptionField: DescriptionModel) {
        guard let description = descriptionField.fieldModel.value else {
            bind(error: .description(common: .description), to: descriptionField)
            return
        }
        
        if description.count > 255 {
            bind(error: .description(common: .descriptionLength), to: descriptionField)
        } else {
            bind(error: nil, to: descriptionField)
        }
        
    }
    
    private func validate(categoriesField: CourseCategoryModel) {
        let categories = categoriesField.selectedCategories
        
        if categories.count < 3 {
            bind(error: .categories, to: categoriesField)
        } else {
            bind(error: nil, to: categoriesField)
        }
    }
    
    private func validate(paymentField: PayForCourseModel?) {
        guard let field = paymentField else {
            return
        }
        
        if field.model.value == .zero {
            bind(error: .payment, to: field)
        } else {
            bind(error: nil, to: field)
        }
    }
    
    private func validate(durationField: CourseDurationCellModel) {
        let duration = durationField.durationModel
        
        if durationField.isInfiniteModel.isSelected {
            bind(error: nil, to: durationField)
        }
        else if duration.isDefault {
            bind(error: .duration(common: .duration), to: durationField)
        }
    }
    
    private func validate(chatField: CourseChatModel) {
        let chatLink = chatField.fieldModel.value
        
        if chatLink.isEmpty {
            bind(error: nil, to: chatField)
        }
        else if let _ = URL(string: chatLink) {
            bind(error: nil, to: chatField)
        }
        else {
            bind(error: .link, to: chatField)
        }
        
    }
    
}
