import Foundation
import XCoordinator
import UIKit

enum AppRoute: Route {
    case authorization
    case main
}

/**
 Класс, отвечающий за переход между авторизованной и неавторизованной частью приложения.
 */
class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private let window: UIWindow
    private var mainRouter: StrongRouter<MainRoute>?
    private var loginRouter: StrongRouter<LoginRoute>?
    
    init(window: UIWindow) {
        self.window = window
        super.init(initialRoute: .authorization)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .authorization:
            mainRouter = nil
            loginRouter = LoginCoordinator(appRouter: unownedRouter).strongRouter
            loginRouter?.setRoot(for: window)
            return .none()

        case .main:
            loginRouter = nil
            mainRouter = MainCoordinator(appRouter: unownedRouter).strongRouter
            mainRouter?.setRoot(for: window)
            return .none()
        }
    }
    
}
