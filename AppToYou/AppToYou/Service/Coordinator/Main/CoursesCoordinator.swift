import Foundation
import XCoordinator

enum CoursesRoute: Route {
    case courses
    case create
}


class CoursesCoordinator: NavigationCoordinator<CoursesRoute> {
    
    init() {
        super.init(initialRoute: .courses)
        configureContainer()
    }
    
    
    override func prepareTransition(for route: CoursesRoute) -> NavigationTransition {
        configureNavBar()
        
        switch route {
        case .courses:
            let coursesViewController = ATYCoursesViewController()
            let coursesViewModel = CoursesViewModelImpl(coursesRouter: unownedRouter)
            coursesViewController.bind(to: coursesViewModel)
            
            return .push(coursesViewController)
            
        case .create:
            let createCourseViewController = CreateCourseViewController()
            createCourseViewController.hidesBottomBarWhenPushed = true
            
            let createCourseViewModel = CreateCourseViewModelImpl(coursesRouter: unownedRouter)
            createCourseViewController.bind(to: createCourseViewModel)
            
            return .push(createCourseViewController)
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.courses(),
                                                     image: R.image.profileNotActive(),
                                                     selectedImage: R.image.profileNotActive())
    }

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        rootViewController.navigationBar.topItem?.backBarButtonItem = backButton
        
        rootViewController.hidesBarsOnSwipe = false
        rootViewController.navigationBar.isHidden = false
        rootViewController.navigationBar.isTranslucent = false
        rootViewController.setNavigationBarHidden(false, animated: false)
    }
    
}
