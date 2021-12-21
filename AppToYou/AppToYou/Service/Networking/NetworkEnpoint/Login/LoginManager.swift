import Foundation


/**
 Сервис обращения к ендпоинту логина сервера.
 */
class LoginManager: NetworkManager<LoginEndpoint> {
    
    func login(credentials: Credentials, completion: @escaping (Result<LoginResponse, NetworkResponseError>) -> Void) {
        request(.login(credentials), responseType: LoginResponse.self, completion)
    }
    
}
