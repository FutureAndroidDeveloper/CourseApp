import Foundation
import XCoordinator

enum CoursesRoute: Route {
    case courses
}


class CoursesCoordinator: NavigationCoordinator<CoursesRoute> {
    
    init() {
        super.init(initialRoute: .courses)
        configureContainer()
    }
    
    
    override func prepareTransition(for route: CoursesRoute) -> NavigationTransition {
        switch route {
        case .courses:
            let vc = ATYCoursesViewController()
            return .push(vc)
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.courses(),
                                                     image: R.image.profileNotActive(),
                                                     selectedImage: R.image.profileNotActive())
    }
    
}
