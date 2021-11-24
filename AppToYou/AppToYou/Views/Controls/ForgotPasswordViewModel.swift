import Foundation
import XCoordinator

protocol ForgotPasswordViewModelInput {
    func resetPaasword(for email: String)
}

protocol ForgotPasswordViewModelOutput {
    
}



protocol ForgotPasswordViewModel {
    var input: ForgotPasswordViewModelInput { get }
    var output: ForgotPasswordViewModelOutput { get }
}

extension ForgotPasswordViewModel where Self: ForgotPasswordViewModelInput & ForgotPasswordViewModelOutput {
    var input: ForgotPasswordViewModelInput { return self }
    var output: ForgotPasswordViewModelOutput { return self }
}


class ForgotPasswordViewModelImpl: ForgotPasswordViewModel, ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {

    private let router: UnownedRouter<ResetPasswordRoute>

    init(router: UnownedRouter<ResetPasswordRoute>) {
        self.router = router
    }
    
    func resetPaasword(for email: String) {
        // validation
        // call reset password endPoint
        router.trigger(.checkEmail)
    }
    
}
