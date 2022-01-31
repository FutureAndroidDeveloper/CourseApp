import Foundation
import XCoordinator


protocol EnterNameViewModelInput {
    func endRegistration()
}

protocol EnterNameViewModelOutput {
    var nameModel: RegistrationNameModel { get }
    var isLoading: Observable<Bool> { get }
}



protocol EnterNameViewModel {
    var input: EnterNameViewModelInput { get }
    var output: EnterNameViewModelOutput { get }
}

extension EnterNameViewModel where Self: EnterNameViewModelInput & EnterNameViewModelOutput {
    var input: EnterNameViewModelInput { return self }
    var output: EnterNameViewModelOutput { return self }
}


class EnterNameViewModelImpl: EnterNameViewModel, EnterNameViewModelInput, EnterNameViewModelOutput {

    var nameModel: RegistrationNameModel
    
    private let router: UnownedRouter<RegistrationRoute>
    private let validator = RegistrationValidator()
    private let userService = UserManager(deviceIdentifierService: DeviceIdentifierService())
    private let loginManager = LoginManager(deviceIdentifierService: DeviceIdentifierService())
    private let credentials: Credentials
    private var createUserRequest: UserCreateRequest?
    
    var isLoading: Observable<Bool> = Observable(false)
    
    init(credentials: Credentials, router: UnownedRouter<RegistrationRoute>) {
        self.credentials = credentials
        self.router = router
        
        let nameFieldModel = TextFieldModel(value: String(), placeholder: R.string.localizable.myNameIs())
        nameModel = RegistrationNameModel(fieldModel: nameFieldModel)
    }
    
    func endRegistration() {
        validator.reset()
        validator.validate(name: nameModel)
        guard !validator.hasError else {
            return
        }
        let name = nameModel.fieldModel.value
        createUserRequest = UserCreateRequest(avatarPath: nil, loginEmailAddress: credentials.mail,
                                              name: name, password: credentials.password)
        save()
    }
    
    private func save() {
        guard let user = createUserRequest else {
            return
        }
        isLoading.value = true
        userService.create(user: user) { [weak self] result in
            switch result {
            case .success(let user):
                self?.login()
            case .failure(let error):
                self?.isLoading.value = false
                self?.displayError(message: error.localizedDescription)
            }
        }
    }
    
    private func login() {
        loginManager.login(credentials: credentials) { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading.value = false
            switch result {
            case .success(let loginResponse):
                if loginResponse.loginStatus == .ok {
                    self.updateUser(credentials: self.credentials, user: loginResponse.userResponse)
                    self.router.trigger(.profileImage)
                }
                else {
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
    
    private func updateUser(credentials: Credentials, user: UserResponse?) {
        guard let encodedData = (credentials.mail + ":" + credentials.password).data(using: .utf8) else {
            return
        }
        
        UserSession.shared.updateEncodedData(encodedData)
        UserSession.shared.updateUser(user)
    }
    
}
