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
        configureNavBar()
        
        switch route {
        case .courses:
            let coursesViewController = CoursesViewController()
            let coursesViewModel = CoursesViewModelImpl(coursesRouter: unownedRouter)
            coursesViewController.bind(to: coursesViewModel)
            
            coursesInput = coursesViewModel
            
            return .push(coursesViewController)
            
        case .preview(let course):
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
//        rootViewController.navigationBar.isHidden = true
        rootViewController.navigationBar.isTranslucent = false
        rootViewController.setNavigationBarHidden(false, animated: false)
    }
    
}

