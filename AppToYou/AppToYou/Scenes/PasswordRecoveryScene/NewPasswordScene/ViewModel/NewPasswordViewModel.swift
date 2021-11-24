import Foundation
import XCoordinator

protocol NewPasswordViewModelInput {
    func savePassword(newPassword: String, repeatPassword: String)
}

protocol NewPasswordViewModelOutput {
    
}



protocol NewPasswordViewModel {
    var input: NewPasswordViewModelInput { get }
    var output: NewPasswordViewModelOutput { get }
}

extension NewPasswordViewModel where Self: NewPasswordViewModelInput & NewPasswordViewModelOutput {
    var input: NewPasswordViewModelInput { return self }
    var output: NewPasswordViewModelOutput { return self }
}


class NewPasswordViewModelImpl: NewPasswordViewModel, NewPasswordViewModelInput, NewPasswordViewModelOutput {

    private let token: String
    private let router: UnownedRouter<ResetPasswordRoute>

    init(token: String, router: UnownedRouter<ResetPasswordRoute>) {
        self.token = token
        self.router = router
    }
    
    func savePassword(newPassword: String, repeatPassword: String) {
        // validation
        // call resetPassword endPoint (with token)
        
        router.trigger(.login)
    }
    
}
