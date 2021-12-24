import Foundation


/**
 Сервис обращения к ендпоинту логина сервера.
 */
class LoginManager: NetworkManager<LoginEndpoint> {
    
    func login(credentials: Credentials, completion: @escaping (Result<LoginResponse, NetworkResponseError>) -> Void) {
        request(.login(credentials), responseType: LoginResponse.self, completion)
    }
    
    func login(credentials: Credentials, update: UpdateInfo, completion: @escaping (Result<LoginResponse, NetworkResponseError>) -> Void) {
        request(.merge(credentials, update: update), responseType: LoginResponse.self, completion)
    }
    
    func login(oAuth: OAuthModel, completion: @escaping (Result<String, NetworkResponseError>) -> Void) {
        request(.oauth(oAuth), responseType: String.self, completion)
        // внутри completion нужно установить encodedData в сессию пользователя
    }
    
}
