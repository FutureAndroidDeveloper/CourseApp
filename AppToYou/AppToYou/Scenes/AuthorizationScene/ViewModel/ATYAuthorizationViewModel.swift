import Foundation
import XCoordinator

protocol AuthorizationViewModelInput {
    func resetTapped()
    func registrationTapped()
    func loginTapped(_ credentials: Credentials)
    func didLogin()
}

protocol AuthorizationViewModelOutput {
    
}



protocol AuthorizationViewModel {
    var input: AuthorizationViewModelInput { get }
    var output: AuthorizationViewModelOutput { get }
}

extension AuthorizationViewModel where Self: AuthorizationViewModelInput & AuthorizationViewModelOutput {
    var input: AuthorizationViewModelInput { return self }
    var output: AuthorizationViewModelOutput { return self }
}


class LoginViewModelImpl: AuthorizationViewModel, AuthorizationViewModelInput, AuthorizationViewModelOutput {

    private let appRouter: UnownedRouter<AppRoute>
    private let router: UnownedRouter<LoginRoute>
    
    private let loginManager: LoginManager

    init(router: UnownedRouter<LoginRoute>, appRouter: UnownedRouter<AppRoute>) {
        self.router = router
        self.appRouter = appRouter
        loginManager = LoginManager(deviceIdentifierService: DeviceIdentifierService())
    }
    
    func loginTapped(_ credentials: Credentials) {
        // validate
        
        loginManager.login(credentials: credentials) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let loginResponse):
                if loginResponse.loginStatus == .ok {
                    self.updateUser(credentials: credentials, user: loginResponse.userResponse)
                    self.didLogin()
                }
                else {
                    self.showLogin(message: loginResponse.loginStatus.message)
                }
                
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func didLogin() {
        appRouter.trigger(.main)
    }
    
    func resetTapped() {
        router.trigger(.reset)
    }
    
    func registrationTapped() {
        router.trigger(.registration)
    }
    
    private func showLogin(message: String?) {
        guard let message = message else {
            return
        }
        
        print(message)
    }
    
    private func updateUser(credentials: Credentials, user: UserResponse?) {
        guard let encodedData = (credentials.mail + ":" + credentials.password).data(using: .utf8) else {
            return
        }
        
        UserSession.shared.updateEncodedData(encodedData)
        UserSession.shared.updateUser(user)
    }
    
}
