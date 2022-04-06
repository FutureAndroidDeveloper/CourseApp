import XCoordinator
import UIKit


enum TaskRoute: Route {
    case add
    case create(TaskType)
    
    case adminEdit(courseName: String, courseTask: CourseTaskResponse)
    case courseTaskEdit(task: Task)
    case editUserTask(task: Task)
        
    case timePicker(type: TimePickerType)
    case sanctionQuestion
    case taskDidCreate
    case done
}


class TaskCoordinator: NavigationCoordinator<TaskRoute> {
    
    private weak var timeReceiver: TimePickerDelegate?
    private let tasksRouter: UnownedRouter<TasksRoute>?
    private let mode: CreateTaskMode
    private let synchronizationService: SynchronizationService
    
    init(mode: CreateTaskMode, synchronizationService: SynchronizationService, rootViewController: RootViewController, tasksRouter: UnownedRouter<TasksRoute>? = nil) {
        self.mode = mode
        self.synchronizationService = synchronizationService
        self.tasksRouter = tasksRouter
        super.init(rootViewController: rootViewController)
        
        switch mode {
        case .createUserTask, .createCourseTask:
            trigger(.add)
            
        case .editUserTask(let task):
            trigger(.editUserTask(task: task))
            
        case .editCourseTask(let task):
            trigger(.courseTaskEdit(task: task))
            
        case .adminEditCourseTask(let name, let task):
            trigger(.adminEdit(courseName: name, courseTask: task))
        }
    }
    
    override func prepareTransition(for route: TaskRoute) -> NavigationTransition {
        configureContainer()
        let taskViewController = ATYCreateTaskViewController()
        taskViewController.hidesBottomBarWhenPushed = true
        
        switch route {
        case .add:
            let chooseTaskTypeViewController = ChooseTaskTypeViewController()
            let chooseTaskTypeViewModel = ChooseTaskTypeViewModelImpl(router: unownedRouter)
            prepare(viewController: chooseTaskTypeViewController, with: chooseTaskTypeViewModel)
            
            let bottomSheetCoordinator = BottomSheetCoordinator(content: chooseTaskTypeViewController)
            chooseTaskTypeViewModel.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .create(let taskType):
            switch mode {
            case .createUserTask:
                let factory = CreateTaskFactory(type: taskType, mode: mode, synchronizationService: synchronizationService)
                prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
                
            case .createCourseTask(let id):
                let factory = CreateCourseTaskFactory(
                    courseId: id, type: taskType, mode: mode,
                    synchronizationService: synchronizationService
                )
                prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
                
            default:
                return .none()
            }
            return .multiple([
                .dismiss(),
                .push(taskViewController)
            ])
            
        case .adminEdit(let courseName, let courseTask):
            let factory = AdminEditCourseTaskFactory(
                courseName: courseName, courseTask: courseTask, mode: mode,
                synchronizationService: synchronizationService
            )
            prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
            return .push(taskViewController)
            
        case .courseTaskEdit(let task):
            let factory = UsereditCourseTaskFactory(task: task, mode: mode, synchronizationService: synchronizationService)
            prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
            return .push(taskViewController)
            
        case .editUserTask(let task):
            let factory = EditUserTaskFactory(task: task, mode: mode, synchronizationService: synchronizationService)
            prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
            return .push(taskViewController)
            
        case .timePicker(let type):
            let timePickerCoordinator = TimePickerCoordinator(type: type, pickerDelegate: timeReceiver)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: timePickerCoordinator)
            timePickerCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .sanctionQuestion:
            let infoCoordinator = UserInfoNotificationCoordinator(notification: .failureSanction)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: infoCoordinator)
            infoCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .taskDidCreate:
            tasksRouter?.trigger(.showTaskDidAddToast)
            return .pop()
            
        case .done:
            return .pop()
        }
    }
    
    private func configureContainer() {
        self.rootViewController.navigationBar.tintColor = R.color.lineViewBackgroundColor()
        self.rootViewController.navigationBar.topItem?.title = String()
    }
    
    private func prepare<T: BindableType>(viewController: T, with viewModel: T.ViewModelType) where T: UIViewController {
        viewController.bind(to: viewModel)
        
        guard let input = viewModel as? TimePickerDelegate else {
            return
        }
        timeReceiver = input
    }
    
}
