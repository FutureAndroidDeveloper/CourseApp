import Foundation


enum LoginStsatus: String, Decodable {
    case ok = "OK"
    case userNotFound = "USER_NOT_FOUND"
    case wrongPassword = "WRONG_PASSWORD"
    
    var message: String? {
        switch self {
        case .ok:
            return nil
        case .userNotFound:
            return "Ошибка логина"
        case .wrongPassword:
            return  "Ошибка пароля"
        }
    }
    
}
