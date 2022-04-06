import Foundation
import XCoordinator

enum LoginRoute: Route {
    case signIn
    case reset
    case registration
    case didLogin
    case error(message: String)
}


class LoginCoordinator: NavigationCoordinator<LoginRoute>, SynchronizationDelegate {
    private let appRouter: UnownedRouter<AppRoute>
    private let synchronizationService: SynchronizationService

    init(synchronizationService: SynchronizationService, appRouter: UnownedRouter<AppRoute>) {
        self.synchronizationService = synchronizationService
        self.appRouter = appRouter
        super.init(initialRoute: .signIn)
        
        synchronizationService.addHandler(self)
    }
    
    override func prepareTransition(for route: LoginRoute) -> NavigationTransition {
        switch route {
        case .signIn:
            let viewController = ATYAuthorizationViewController()
            let viewModel = LoginViewModelImpl(synchronizationService: synchronizationService, router: unownedRouter)
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
            let registrationCoordinator = RegistrationCoordinator(rootViewController: self.rootViewController)
            addChild(registrationCoordinator)
            return .none()
            
        case .didLogin:
            appRouter.trigger(.main)
            return .none()
            
        case .error(let message):
            let errorCoordinator = ErrorAlertCoordinator(message: message)
            return .present(errorCoordinator)
        }
    }
    
    func synchronizationDidStart() {
        // pass
    }
    
    func synchronizationDidFinish(result: Result<Double, Error>) {
        switch result {
        case .success(let duration):
            let delay = duration + synchronizationService.resultAlertDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.trigger(.didLogin)
            }
            
        case .failure:
            break
        }
    }
    
}
