import Foundation


enum LoginStsatus: String, Decodable, ValidationError {
    case empty
    case ok = "OK"
    case userNotFound = "USER_NOT_FOUND"
    case wrongPassword = "WRONG_PASSWORD"
    
    var message: String? {
        switch self {
        case .ok:
            return nil
        case .empty:
            return "Заполните поле"
        case .userNotFound:
            return "Ошибка логина"
        case .wrongPassword:
            return  "Ошибка пароля"
        }
    }
    
}
