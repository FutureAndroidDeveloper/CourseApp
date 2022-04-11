import XCoordinator


enum PreviewCourseTaskRoute: Route {
    case showBuy(course: CourseResponse)
    case open(course: CourseResponse)
    case done
}


class PreviewCourseCoordinator: ViewCoordinator<PreviewCourseTaskRoute> {
    weak var flowDelegate: FlowEndHandlerDelegate?
    private let coursesRouter: UnownedRouter<CoursesRoute>
    
    init(course: CourseResponse, coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        let previewCourseViewController = CoursePreviewViewController()
        super.init(rootViewController: previewCourseViewController)
        
        let previewCourseViewModel = CoursePreviewViewModellImpl(course: course, router: unownedRouter)
        previewCourseViewController.bind(to: previewCourseViewModel)
        
    }
    
    override func prepareTransition(for route: PreviewCourseTaskRoute) -> ViewTransition {
        switch route {
        case .showBuy(let course):
            return .none()
            
        case .open(let course):
            return .multiple([
                .dismiss(),
                .trigger(.openCourse(course: course), on: coursesRouter)
            ])
            
        case .done:
            return .dismiss()
        }
    }
    
}
