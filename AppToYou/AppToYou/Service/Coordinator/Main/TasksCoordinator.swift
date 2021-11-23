import Foundation
import XCoordinator

enum TasksRoute: Route {
    case tasks
}


class TasksCoordinator: NavigationCoordinator<TasksRoute> {
    
    init() {
        super.init(initialRoute: .tasks)
        configureContainer()
    }
    
    override func prepareTransition(for route: TasksRoute) -> NavigationTransition {
        switch route {
        case .tasks:
            let vc = NavigationBarViewController()
            return .push(vc)
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tasks(),
                                                     image: R.image.targetNotActive(),
                                                     selectedImage: R.image.targetActive())
    }
    
}
