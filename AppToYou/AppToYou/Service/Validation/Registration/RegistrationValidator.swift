import Foundation


enum RegistrationError: ValidationError {
    case emptyEmail
    case invalidEmail
    case longEmail
    
    case emptyPassword
    case invalidPassword
    case longPassword
    
    case emptyName
    case longName
    
    var message: String? {
        switch self {
        case .emptyEmail:
            return "Укажите email"
        case .invalidEmail:
            return "Проверьте корректность email"
        case .longEmail:
            return "Не более 64 символов"
            
        case .emptyPassword:
            return "Укажите пароль"
        case .invalidPassword:
            return "Проверьте корректность пароля"
        case .longPassword:
            return "Не более 128 символов"
        
        case .emptyName:
            return "Укажите имя"
        case .longName:
            return "Не более 128 символов"
        }
    }
    
}


class RegistrationValidator: Validating {
    var hasError: Bool
    
    init() {
        hasError = false
    }
    
    func bind(error: RegistrationError?, to receiver: ValidationErrorDisplayable) {
        updateErrorState(new: error)
        receiver.bind(error: error)
    }
    
    func updateErrorState(new error: ValidationError?) {
        let isFiledHasError = error == nil ? false : true
        hasError = hasError || isFiledHasError
    }
    
    func reset() {
        hasError = false
    }
    
     func validate(email field: RegistrationEmailModel) {
         let email = field.fieldModel.value
         if email.isEmpty {
             bind(error: .emptyEmail, to: field)
             return
         } else if email.count > 64 {
             bind(error: .longEmail, to: field)
             return
         }
         
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         if emailPred.evaluate(with: email) {
             bind(error: nil, to: field)
         } else {
             bind(error: .invalidEmail, to: field)
         }
    }
    
    func validate(password field: RegistrationPasswordModel) {
        let password = field.fieldModel.value
        if password.isEmpty {
             bind(error: .emptyPassword, to: field)
            return
        } else if password.count > 128 {
             bind(error: .longPassword, to: field)
            return
        }
        
        let passwordRegEx = #"^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$"#
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        if passwordPred.evaluate(with: password) {
             bind(error: nil, to: field)
        } else {
             bind(error: .invalidPassword, to: field)
        }
   }
    
    func validate(name field: RegistrationNameModel) {
        let name = field.fieldModel.value
        if name.isEmpty {
             bind(error: .emptyName, to: field)
            return
        } else if name.count > 128 {
             bind(error: .longName, to: field)
            return
        }
   }
    
}
