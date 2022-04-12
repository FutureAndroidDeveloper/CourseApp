import Foundation
import XCoordinator

protocol AuthorizationViewModelInput {
    func resetTapped()
    func registrationTapped()
    func loginTapped()
    func continueFlow()
    
    func useAppleAccount()
    func useGoogleAccount()
}

protocol AuthorizationViewModelOutput {
    var emailModel: LoginEmailModel { get }
    var passwordModel: LoginPasswordModel { get }
    var isLoading: Observable<Bool> { get }
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
    
    var emailModel: LoginEmailModel
    var passwordModel: LoginPasswordModel
    var isLoading: Observable<Bool> = Observable(false)
    
    private let router: UnownedRouter<LoginRoute>
    private let loginManager = LoginManager(deviceIdentifierService: DeviceIdentifierService())
    private let synchronizationService: SynchronizationService

    init(synchronizationService: SynchronizationService, router: UnownedRouter<LoginRoute>) {
        self.synchronizationService = synchronizationService
        self.router = router
        
        let emailFieldModel = TextFieldModel(value: String(), placeholder: R.string.localizable.enterYourEmail())
        let passwordFieldModel = TextFieldModel(value: String(), placeholder: R.string.localizable.enterPassword())
        emailModel = LoginEmailModel(fieldModel: emailFieldModel)
        passwordModel = LoginPasswordModel(fieldModel: passwordFieldModel)
    }
    
    func loginTapped() {
        let mail = emailModel.fieldModel.value
        let password = passwordModel.fieldModel.value
        
        let credentials = Credentials(mail: mail, password: password)
        guard validate(credentials: credentials) else {
            return
        }
        
        isLoading.value = true
        loginManager.login(credentials: credentials) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading.value = false
            switch result {
            case .success(let loginResponse):
                if loginResponse.loginStatus == .ok {
                    self.updateUser(credentials: credentials, user: loginResponse.userResponse)
                    self.synchronizationService.validateResults()
                    self.synchronizationService.synchronize()
                }
                else {
                    self.bindError(loginResponse.loginStatus)
                    self.displayError(message: loginResponse.loginStatus.message ?? String())
                }
            case .failure(let error):
                self.displayError(message: error.localizedDescription)
            }
        }
    }
    
    private func displayError(message: String) {
        router.trigger(.error(message: message))
    }
    
    func validate(credentials: Credentials) -> Bool {
        var result = true
        let mail = credentials.mail
        let password = credentials.password
        
        if mail.isEmpty {
            emailModel.bind(error: LoginStsatus.empty)
            result = false
        } else {
            emailModel.bind(error: nil)
        }
        
        if password.isEmpty {
            passwordModel.bind(error: LoginStsatus.empty)
            result = false
        } else {
            passwordModel.bind(error: nil)
        }
        return result
    }
    
    func didLogin() {
        router.trigger(.didLogin)
    }
    
    func resetTapped() {
        router.trigger(.reset)
    }
    
    func registrationTapped() {
        router.trigger(.registration)
    }
    
    func continueFlow() {
        synchronizationService.validateResults()
        router.trigger(.didLogin)
    }
    
    func useAppleAccount() {
        print("Apple")
    }
    
    func useGoogleAccount() {
        print("Google")
    }
    
    private func bindError(_ error: LoginStsatus) {
        switch error {
        case .empty, .ok:
            break
        case .userNotFound:
            emailModel.bind(error: LoginStsatus.userNotFound)
        case .wrongPassword:
            passwordModel.bind(error: LoginStsatus.wrongPassword)
        }
    }
    
    private func updateUser(credentials: Credentials, user: UserResponse?) {
        guard let encodedData = (credentials.mail + ":" + credentials.password).data(using: .utf8) else {
            return
        }
        
        UserSession.shared.updateEncodedData(encodedData)
        UserSession.shared.updateUser(user)
    }
    
}
