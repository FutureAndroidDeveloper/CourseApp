import UIKit
import XCoordinator


enum CoursesRoute: Route {
    case courses
    case create
    
    case photo(image: UIImage?)
    case durationPicker
}


class CoursesCoordinator: NavigationCoordinator<CoursesRoute> {
    
    private weak var courseCreationInput: CreateCourseViewModelInput?
    
    
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
            
            let createCourseViewModel = CreateCourseViewModelImpl(mode: .creation, coursesRouter: unownedRouter)
            createCourseViewController.bind(to: createCourseViewModel)
            courseCreationInput = createCourseViewModel
            
            return .push(createCourseViewController)
            
        case .photo(let image):
            let photoCoordinator = PhotoCoordinator(image: image,
                                                    photoDelegate: courseCreationInput,
                                                    rootViewController: self.rootViewController)
            addChild(photoCoordinator)
            return .none()
            
        case .durationPicker:
            let timePickerCoordinator = TimePickerCoordinator(type: .duration,
                                                              pickerDelegate: courseCreationInput,
                                                              rootViewController: self.rootViewController)
            addChild(timePickerCoordinator)
            return .none()
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
