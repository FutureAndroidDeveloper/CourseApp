import Foundation
import XCoordinator


enum CourseRoute: Route {
    case course(CourseResponse)
    case back
    case edit
    case requests
    case chat
    case addAll
    case add(task: CourseTaskResponse)
    case createTask
    case editTask(task: CourseTaskResponse)
    case members
    case share
    case report
}


class CourseCoordinator: NavigationCoordinator<CourseRoute> {
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let course: CourseResponse
    
    
    init(course: CourseResponse, coursesRouter: UnownedRouter<CoursesRoute>, rootViewController: RootViewController) {
        self.course = course
        self.coursesRouter = coursesRouter
        super.init(rootViewController: rootViewController)
        trigger(.course(course))
    }
    
    override func prepareTransition(for route: CourseRoute) -> NavigationTransition {
//        configureContainer(hideNavBar: false)
        
        switch route {
        case .course(let course):
            configureContainer(hideNavBar: true)
            let courseViewController = CourseViewController()
            let courseViewModel = CourseViewModelImpl(course: course, coursesRouter: unownedRouter)
            courseViewController.bind(to: courseViewModel)
            
            return .push(courseViewController)
            
        case .back:
            return .pop()
            
        case .edit:
            coursesRouter.trigger(.createEdit(course: course))
            return .none()
            
        case .requests:
            let requests = ATYCourseParticipantsViewController()
            return .push(requests)
            
        case .chat:
            break
            
        case .addAll:
            let notification = ATYTaskAddedViewController(type: .allTasks)
            return .push(notification)
            
        case .add(let task):
            configureContainer(hideNavBar: true)
            let taskCoordinator = TaskCoordinator(mode: .addCourseTask(task), rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
            
        case .createTask:
            let id = course.id
            let taskCoordinator = TaskCoordinator(mode: .createCourseTask(courseId: id), rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
            
        case .editTask(let task):
            let name = course.name
            let taskCoordinator = TaskCoordinator(mode: .adminEditCourseTask(courseName: name, task: task), rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
            
        case .members:
            let members = ATYCourseRatingViewController()
            return .push(members)
            
        case .share:
            break
        case .report:
            break
        }
        
        return .none()
    }
    
    private func configureContainer(hideNavBar: Bool) {
        rootViewController.hidesBarsOnSwipe = false
        rootViewController.navigationBar.isHidden = hideNavBar
        rootViewController.navigationBar.isTranslucent = hideNavBar
        rootViewController.setNavigationBarHidden(hideNavBar, animated: false)
    }
}
