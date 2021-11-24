import Foundation
import XCoordinator

enum LoginRoute: Route {
    case signIn
    case reset
    case registration
    case didLogin
}


class LoginCoordinator: NavigationCoordinator<LoginRoute> {
    
    private let appRouter: UnownedRouter<AppRoute>

    init(appRouter: UnownedRouter<AppRoute>) {
        self.appRouter = appRouter
        super.init(initialRoute: .signIn)
    }
    
    override func prepareTransition(for route: LoginRoute) -> NavigationTransition {
        switch route {
        case .signIn:
            let viewController = ATYAuthorizationViewController()
            let viewModel = LoginViewModelImpl(router: unownedRouter, appRouter: appRouter)
            viewController.bind(to: viewModel)
            
            return .multiple([
                .dismissToRoot(),
                .popToRoot(),
                .set([viewController])
            ])
            
        case .reset:
            let resetPasswordCoordinator = ResetPasswordCoordinator(rootViewController: self.rootViewController)
            addChild(resetPasswordCoordinator)
            return .none()
            
        case .registration:
            let registrationCoordinator = RegistrationCoordinator(loginRouter: unownedRouter,
                                                                  rootViewController: self.rootViewController)
            addChild(registrationCoordinator)
            return .none()
            
        case .didLogin:
            appRouter.trigger(.main)
            return .none()
        }
    }
    
}
