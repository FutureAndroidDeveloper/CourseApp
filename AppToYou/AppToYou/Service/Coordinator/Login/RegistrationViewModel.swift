import Foundation
import XCoordinator

protocol RegistrationViewModelInput {
    func credentialsEntered(mail: String, password: String)
    func open(url: URL)
}

protocol RegistrationViewModelOutput {
    
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

    private let router: UnownedRouter<RegistrationRoute>

    init(router: UnownedRouter<RegistrationRoute>) {
        self.router = router
    }
    
    func credentialsEntered(mail: String, password: String) {
        // validation
        
        router.trigger(.credentials(mail: mail, password: password))
    }
    
    func open(url: URL) {
        router.trigger(.url(url))
    }
    
}
