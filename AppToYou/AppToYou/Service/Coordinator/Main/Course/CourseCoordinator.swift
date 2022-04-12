import Foundation
import XCoordinator
import UIKit


enum CourseRoute: Route {
    case course(CourseResponse)
    case back
    case edit
    case requests
    case chat
    case addAll
    case taskDidAdd
    case add(task: CourseTaskResponse)
    case createTask
    case editTask(task: CourseTaskResponse)
    case members
    case share
    case report
    
    case confirmDeletion
    case configureContainer
}


class CourseCoordinator: NavigationCoordinator<CourseRoute> {
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let course: CourseResponse
    private let synchronizationService: SynchronizationService
    
    private weak var courseInput: CourseViewModelInput?
    
    
    init(course: CourseResponse, coursesRouter: UnownedRouter<CoursesRoute>,
         synchronizationService: SynchronizationService, rootViewController: RootViewController) {
        self.course = course
        self.coursesRouter = coursesRouter
        self.synchronizationService = synchronizationService
        super.init(rootViewController: rootViewController)
    }
    
    override func prepareTransition(for route: CourseRoute) -> NavigationTransition {
        configureContainer(hideNavBar: true)
        
        switch route {
        case .course(let course):
            let courseViewController = CourseViewController()
            let courseViewModel = CourseViewModelImpl(
                course: course,
                synchronizationService: synchronizationService,
                coursesRouter: unownedRouter
            )
            courseViewController.bind(to: courseViewModel)
            courseInput = courseViewModel
            
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
            let infoCoordinator = UserInfoNotificationCoordinator(notification: .allCourseTasksAdded)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: infoCoordinator)
            infoCoordinator.flowDelegate = bottomSheetCoordinator
            
            infoCoordinator.addAllTasksDidTap = { [weak self] in
                self?.courseInput?.addAllTasks()
            }
            
            return .present(bottomSheetCoordinator)
            
        case .add(let task):
            let addTaskCoordinator = AddTaskSheetCoordinator(task: task)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: addTaskCoordinator)
            addTaskCoordinator.flowDelegate = bottomSheetCoordinator
            
            addTaskCoordinator.taskDidAdd = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    self?.trigger(.taskDidAdd)
                    self?.courseInput?.refresh()
                }
            }
            return .present(bottomSheetCoordinator)
            
        case .taskDidAdd:
            let infoCoordinator = UserInfoNotificationCoordinator(notification: .courseTaskAdded)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: infoCoordinator)
            infoCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .createTask:
            configureContainer(hideNavBar: false)
            let id = course.id
            let taskCoordinator = TaskCoordinator(
                mode: .createCourseTask(courseId: id),
                synchronizationService: synchronizationService,
                rootViewController: self.rootViewController
            )
            addChild(taskCoordinator)
            return .none()
            
        case .editTask(let task):
            configureContainer(hideNavBar: false)
            let name = course.name
            let taskCoordinator = TaskCoordinator(
                mode: .adminEditCourseTask(courseName: name, task: task),
                synchronizationService: synchronizationService,
                rootViewController: self.rootViewController
            )
            addChild(taskCoordinator)
            return .none()
            
        case .members:
            configureContainer(hideNavBar: false)
            let members = ATYCourseRatingViewController()
            return .push(members)
            
        case .share:
            break
        case .report:
            break
        case .confirmDeletion:
            showConfirmTaskDeletionAlert()
            break
        case .configureContainer:
            configureContainer(hideNavBar: true)
            break
        }
        
        return .none()
    }
    
    private func configureContainer(hideNavBar: Bool) {
        rootViewController.navigationBar.tintColor = R.color.lineViewBackgroundColor()
        rootViewController.navigationBar.topItem?.title = String()
        
        rootViewController.hidesBarsOnSwipe = false
        rootViewController.navigationBar.isHidden = hideNavBar
        rootViewController.navigationBar.isTranslucent = hideNavBar
        rootViewController.setNavigationBarHidden(hideNavBar, animated: false)
    }
    
    private func showConfirmTaskDeletionAlert() {
        let alert = UIAlertController(title: "Удалить задачу?", message: "Прогресс будет потерян", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            self?.courseInput?.deleteTask()
            self?.courseInput?.refresh()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { [weak self] _ in
            self?.courseInput?.refresh()
        }))
        rootViewController.present(alert, animated: true)
    }
}
