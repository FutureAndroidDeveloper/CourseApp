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
            let second = RegistrationCoordinator(loginRouter: unownedRouter, rootViewController: self.rootViewController)
            addChild(second)
            return .none()
            
        case .didLogin:
            appRouter.trigger(.main)
            return .none()
        }
    }
    
}
