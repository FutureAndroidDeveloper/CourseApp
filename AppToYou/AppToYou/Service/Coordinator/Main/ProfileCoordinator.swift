import Foundation
import XCoordinator

enum ProfileRoute: Route {
    case profile
    case logout
}


class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    
    private let appRouter: UnownedRouter<AppRoute>
    
    init(appRouter: UnownedRouter<AppRoute>) {
        self.appRouter = appRouter
        super.init(initialRoute: .profile)
        configureContainer()
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        switch route {
        case .profile:
            let viewController = ATYProfileSignInViewController()
            let viewModel = ProfileViewModelImpl(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)
            
        case .logout:
            print("logout")
            // TODO: проверить что будет, если есть PopUp (возможно сразу нужно сделать дисмисс)
            return .trigger(.authorization, on: appRouter)
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.profile(),
                                                     image: R.image.profileNotActive(),
                                                     selectedImage: R.image.profileNotActive())
    }
    
}
