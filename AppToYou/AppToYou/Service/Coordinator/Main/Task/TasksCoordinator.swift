import Foundation
import Toast_Swift
import XCoordinator


enum TasksRoute: Route {
    case tasks
    case create
    case editUserTask(task: Task)
    case editCourseTask(task: Task)
    case showSanction(task: UserTaskResponse)
    case showCountPicker(task: Task, result: RealmTaskResult, change: CountChange)
    case openTextAnswer(task: Task, result: RealmTaskResult)
    
    case showTaskDidAddToast
}


class TasksCoordinator: NavigationCoordinator<TasksRoute> {
    private let synchronizationService = SynchronizationService()
    
    init() {
        super.init(initialRoute: .tasks)
        configureContainer()
    }
    
    override func prepareTransition(for route: TasksRoute) -> NavigationTransition {
        switch route {
        case .tasks:
            let allTasksViewController = ATYAllTasksViewController(title: R.string.localizable.allTasks())
            let allTasksViewModel = AllTasksViewModelImpl(synchronizationService: synchronizationService, router: unownedRouter)
            allTasksViewController.bind(to: allTasksViewModel)
            
            let toodayTaskViewController = ToodayTaskViewController(title: R.string.localizable.today())
            let todayTasksViewModel = TodayTasksViewModelImpl(synchronizationService: synchronizationService, router: unownedRouter)
            toodayTaskViewController.bind(to: todayTasksViewModel)
            
            let tasksViewController = NavigationBarViewController(viewControllers: [toodayTaskViewController, allTasksViewController])
            return .push(tasksViewController)
            
        case .create:
            let taskCoordinator = TaskCoordinator(
                mode: .createUserTask,
                synchronizationService: self.synchronizationService,
                rootViewController: self.rootViewController,
                tasksRouter: unownedRouter
            )
            addChild(taskCoordinator)
            return .none()
            
        case .editUserTask(let task):
            let taskCoordinator = TaskCoordinator(
                mode: .editUserTask(task: task),
                synchronizationService: self.synchronizationService,
                rootViewController: self.rootViewController
            )
            addChild(taskCoordinator)
            return .none()
            
        case .editCourseTask(let task):
            let taskCoordinator = TaskCoordinator(
                mode: .editCourseTask(task: task),
                synchronizationService: self.synchronizationService,
                rootViewController: self.rootViewController
            )
            addChild(taskCoordinator)
            return .none()
            
        case .openTextAnswer(let task, let result):
            let textAnswerCoordinator = TextAnswerCoordinator(task: task, result: result, rootViewController: self.rootViewController)
            addChild(textAnswerCoordinator)
            return .none()
            
        case .showSanction(let task):
            let infoCoordinator = UserInfoNotificationCoordinator(notification: .paySanction(task: task))
            let bottomSheetCoordinator = BottomSheetCoordinator(content: infoCoordinator)
            infoCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .showCountPicker(let task, let result, let change):
            let countPickerCoordinator = CountPickerCoordinator(task: task, result: result, change: change)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: countPickerCoordinator)
            countPickerCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .showTaskDidAddToast:
            let toast = TaskDidCreateToastView(frame: viewController.view.frame)
            self.rootViewController.view.showToast(toast, duration: 3, position: .bottom)
            return .none()
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tasks(),
                                                     image: R.image.targetNotActive(),
                                                     selectedImage: R.image.targetActive())
    }
    
}
