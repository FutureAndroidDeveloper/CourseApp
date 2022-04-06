import Foundation
import XCoordinator
import UIKit


enum AppRoute: Route {
    case authorization
    case main
    
    case startSynchronization
    case endSynchronization
}


/**
 Класс, отвечающий за переход между авторизованной и неавторизованной частью приложения.
 */
class AppCoordinator: NavigationCoordinator<AppRoute>, SynchronizationDelegate {
    
    private let window: UIWindow
    private let synchronizationService = SynchronizationService()
    private let syncAlertCoordinator = SyncAlertCoordinator()
    private var mainRouter: StrongRouter<MainRoute>?
    private var loginRouter: StrongRouter<LoginRoute>?
    
    init(window: UIWindow) {
        self.window = window
        super.init(initialRoute: .authorization)
        
        synchronizationService.addHandler(self)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .authorization:
            mainRouter = nil
            loginRouter = LoginCoordinator(synchronizationService: synchronizationService, appRouter: unownedRouter).strongRouter
            loginRouter?.setRoot(for: window)
            return .none()

        case .main:
            loginRouter = nil
            mainRouter = MainCoordinator(appRouter: unownedRouter).strongRouter
            mainRouter?.setRoot(for: window)
            return .none()
            
        case .endSynchronization:
            syncAlertCoordinator.viewController.dismiss(animated: true)
            return .none()
            
        case .startSynchronization:
            window.rootViewController?.present(syncAlertCoordinator.viewController, animated: true)
            return .none()
        }
        
    }
    
    func synchronizationDidStart() {
        syncAlertCoordinator.loading()
        trigger(.startSynchronization)
    }
    
    func synchronizationDidFinish(result: Result<Double, Error>) {
        switch result {
        case .success(let duration):
            self.endSynchronization(duration: duration)
        case .failure(let error):
            endSynchronization(duration: .zero, error: error)
        }
    }
    
    private func endSynchronization(duration: Double, error: Error? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            guard let self = self else {
                return
            }
            
            if let error = error {
                self.syncAlertCoordinator.error(message: error.localizedDescription)
            } else {
                self.syncAlertCoordinator.finished()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.synchronizationService.resultAlertDuration) { [weak self] in
                self?.trigger(.endSynchronization)
            }
        }
    }
    
}
