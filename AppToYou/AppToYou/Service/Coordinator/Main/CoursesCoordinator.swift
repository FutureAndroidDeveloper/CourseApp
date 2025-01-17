import UIKit
import XCoordinator


enum CoursesRoute: Route {
    case courses
    case createEdit(course: CourseResponse?)
    
    case openCourse(course: CourseResponse)
    
    case courseCreated(course: CourseResponse)
    
    case preview(course: CourseResponse)
    
    case photo(image: UIImage?)
    case durationPicker
}


class CoursesCoordinator: NavigationCoordinator<CoursesRoute> {
    
    private weak var courseCreationInput: CreateCourseViewModelInput?
    private weak var coursesInput: CoursesViewModelInput?
    private let synchronizationService = SynchronizationService()
    
    
    init() {
        super.init(initialRoute: .courses)
        configureContainer()
    }
    
    override func prepareTransition(for route: CoursesRoute) -> NavigationTransition {
        switch route {
        case .courses:
            configureContainer(hideNavBar: true)
            let coursesViewController = CoursesViewController()
            let coursesViewModel = CoursesViewModelImpl(coursesRouter: unownedRouter)
            coursesViewController.bind(to: coursesViewModel)
            
            coursesInput = coursesViewModel
            
            return .push(coursesViewController)
            
        case .preview(let course):
            configureContainer(hideNavBar: true)
            let previewCourseCoordinator = PreviewCourseCoordinator(course: course, coursesRouter: unownedRouter)
            let config = BottomSheetConfiguration(maxTopOffset: 0, pullBarHeight: 0, cornerRadius: nil)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: previewCourseCoordinator, config: config)
            return .present(bottomSheetCoordinator)
            
        case .openCourse(let course):
            let courseCoordinator = CourseCoordinator(course: course,
                                                      coursesRouter: unownedRouter,
                                                      synchronizationService: synchronizationService,
                                                      rootViewController: self.rootViewController)
            addChild(courseCoordinator)
            return .multiple([
                .dismiss(),
                .route(.course(course), on: courseCoordinator)
            ])
            
        case .createEdit(let course):
            configureContainer(hideNavBar: false)
            let createCourseViewController = CreateCourseViewController()
            createCourseViewController.hidesBottomBarWhenPushed = true
            
            let createCourseViewModel = CreateCourseViewModelImpl(course: course, coursesRouter: unownedRouter)
            createCourseViewController.bind(to: createCourseViewModel)
            courseCreationInput = createCourseViewModel
            
            return .push(createCourseViewController)
            
        case .courseCreated(let course):
            coursesInput?.refresh()
            return .pop()
            
        case .photo(let image):
            let photoCoordinator = PhotoCoordinator(image: image,
                                                    photoDelegate: courseCreationInput,
                                                    rootViewController: self.rootViewController)
            addChild(photoCoordinator)
            return .none()
            
        case .durationPicker:
            let timePickerCoordinator = TimePickerCoordinator(type: .course, pickerDelegate: courseCreationInput)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: timePickerCoordinator)
            timePickerCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.courses(),
                                                     image: R.image.rocketNotActive(),
                                                     selectedImage: R.image.rocketActive())
    }
    
    private func configureContainer(hideNavBar: Bool) {
        rootViewController.navigationBar.tintColor = R.color.lineViewBackgroundColor()
        rootViewController.navigationBar.topItem?.title = String()
        
        rootViewController.hidesBarsOnSwipe = false
        rootViewController.navigationBar.isHidden = hideNavBar
        rootViewController.navigationBar.isTranslucent = hideNavBar
        rootViewController.setNavigationBarHidden(hideNavBar, animated: false)
    }
}

