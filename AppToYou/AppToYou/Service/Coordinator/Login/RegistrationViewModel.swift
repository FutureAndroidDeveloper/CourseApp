import Foundation
import XCoordinator

protocol RegistrationViewModelInput {
    func register()
    func back()
    func createAppleAccount()
    func createGoogleAccount()
    func open(url: URL)
}

protocol RegistrationViewModelOutput {
    var emailModel: RegistrationEmailModel { get }
    var passwordModel: RegistrationPasswordModel { get }
}



protocol RegistrationViewModel {
    var input: RegistrationViewModelInput { get }
    var output: RegistrationViewModelOutput { get }
}

extension RegistrationViewModel where Self: RegistrationViewModelInput & RegistrationViewModelOutput {
    var input: RegistrationViewModelInput { return self }
    var output: RegistrationViewModelOutput { return self }
}


class RegistrationViewModelImpl: RegistrationViewModel, RegistrationViewModelInput, RegistrationViewModelOutput {
    
    var emailModel: RegistrationEmailModel
    var passwordModel: RegistrationPasswordModel

    private let router: UnownedRouter<RegistrationRoute>
    private let validator = RegistrationValidator()

    init(router: UnownedRouter<RegistrationRoute>) {
        self.router = router
        
        let emailFieldModel = TextFieldModel(value: String(), placeholder: R.string.localizable.enterYourEmail())
        let passwordFieldModel = TextFieldModel(value: String(), placeholder: R.string.localizable.pickAPassword())
        emailModel = RegistrationEmailModel(fieldModel: emailFieldModel)
        passwordModel = RegistrationPasswordModel(fieldModel: passwordFieldModel)
    }
    
    func register() {
        validator.reset()
        validator.validate(email: emailModel)
        validator.validate(password: passwordModel)
        guard !validator.hasError else {
            return
        }
        
        let mail = emailModel.fieldModel.value
        let password = passwordModel.fieldModel.value
        let credentials = Credentials(mail: mail, password: password)
        router.trigger(.name(credentials))
    }
    
    func back() {
        router.trigger(.haveAccount)
    }
    
    func createAppleAccount() {
        print("Apple")
    }
    
    func createGoogleAccount() {
        print("Google")
    }
    
    func open(url: URL) {
        router.trigger(.url(url))
    }
    
}
