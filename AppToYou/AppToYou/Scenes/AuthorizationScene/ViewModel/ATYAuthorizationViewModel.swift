import Foundation
import XCoordinator

protocol AuthorizationViewModelInput {
    func resetTapped()
    func registrationTapped()
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

    init(router: UnownedRouter<LoginRoute>, appRouter: UnownedRouter<AppRoute>) {
        self.router = router
        self.appRouter = appRouter
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
    
}
