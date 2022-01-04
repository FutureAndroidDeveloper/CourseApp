import Foundation
import XCoordinator


enum TasksRoute: Route {
    case tasks
    case create
    case editUserTask(task: UserTaskResponse)
    case editCourseTask(task: UserTaskResponse)
}


// Разбить координатор на отдельные
class TasksCoordinator: NavigationCoordinator<TasksRoute> {
    
    private weak var createTaskInput: CreateTaskViewModelInput?
    
    
    init() {
        super.init(initialRoute: .tasks)
        configureContainer()
    }
    
    override func prepareTransition(for route: TasksRoute) -> NavigationTransition {
        switch route {
        case .tasks:
            let allTasksViewController = ATYAllTasksViewController(title: R.string.localizable.allTasks())
            let allTasksViewModel = AllTasksViewModelImpl(router: unownedRouter)
            allTasksViewController.bind(to: allTasksViewModel)
            
            let toodayTaskViewController = ToodayTaskViewController(title: R.string.localizable.today())
            let todayTasksViewModel = TodayTasksViewModelImpl(router: unownedRouter)
            toodayTaskViewController.bind(to: todayTasksViewModel)
            
            let tasksViewController = NavigationBarViewController(viewControllers: [toodayTaskViewController, allTasksViewController])
            return .push(tasksViewController)
            
        case .create:
            let taskCoordinator = TaskCoordinator(mode: .createUserTask, rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
            
        case .editUserTask(let task):
            let taskCoordinator = TaskCoordinator(mode: .editUserTask(task: task), rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
            
        case .editCourseTask(let task):
            let taskCoordinator = TaskCoordinator(mode: .editCourseTask(task: task), rootViewController: self.rootViewController)
            addChild(taskCoordinator)
            return .none()
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tasks(),
                                                     image: R.image.targetNotActive(),
                                                     selectedImage: R.image.targetActive())
    }
    
}
