import Foundation


enum UserEditCourseTaskError: ValidationError {
    case enableSanction
    
    var message: String? {
        switch self {
        case .enableSanction:
            return "Невозможно отключить штраф у этой задачи"
        }
    }
    
}


class UserEditCourseTaskValidator: CheckboxTaskValidator<UserEditCourseTaskModel> {

    override func validate(model: UserEditCourseTaskModel) {
        super.validate(model: model)
        validate(sanctionField: model.sanctionModel)
    }
    
    func bind(error: UserEditCourseTaskError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        receiver.bind(error: error)
    }
    
    
    private func validate(sanctionField: TaskSanctionModel) {
        if sanctionField.minValue > .zero, !sanctionField.isEnabled {
            bind(error: .enableSanction, to: sanctionField)
        } else {
            super.bind(error: nil, to: sanctionField)
        }
    }
    
}

