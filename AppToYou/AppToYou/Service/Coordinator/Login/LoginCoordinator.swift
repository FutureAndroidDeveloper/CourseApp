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
    private var registrationRouter: StrongRouter<RegistrationRoute>?

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
            
//            return .set([viewController])
            return .multiple([
                .dismissToRoot(),
                .popToRoot(),
                .set([viewController])
            ])
            
        case .reset:
            let forgotVc = ATYForgotPasswordViewController()
            return .push(forgotVc)
            
        case .registration:
            registrationRouter = RegistrationCoordinator(loginRouter: unownedRouter, rootViewController: rootViewController).strongRouter
            return .none()
            
        case .didLogin:
            appRouter.trigger(.main)
            return .none()
        }
    }
    
}
