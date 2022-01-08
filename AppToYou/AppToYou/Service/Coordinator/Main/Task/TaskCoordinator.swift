import Foundation
import XCoordinator
import UIKit


enum TaskRoute: Route {
    case add
    case create(ATYTaskType)
    
    case adminEdit(courseName: String, courseTask: CourseTaskResponse)
    case courseTaskEdit(userTask: UserTaskResponse)
    
    case addCourseTask(_ task: CourseTaskResponse)
    
    case timePicker(type: TimePickerType)
    case done
}


class TaskCoordinator: NavigationCoordinator<TaskRoute> {
    
    private weak var timeReceiver: TimePickerDelegate?
    private let mode: CreateTaskMode
    
    init(mode: CreateTaskMode, rootViewController: RootViewController) {
        self.mode = mode
        super.init(rootViewController: rootViewController)
        
        switch mode {
        case .createUserTask, .createCourseTask:
            trigger(.add)
            
        case .addCourseTask(let task):
            trigger(.addCourseTask(task))
            
        case .editUserTask(let task):
            trigger(.create(task.taskType))
            
        case .editCourseTask(let task):
            trigger(.courseTaskEdit(userTask: task))
            
        case .adminEditCourseTask(let name, let task):
            trigger(.adminEdit(courseName: name, courseTask: task))
        }
    }
    
    override func prepareTransition(for route: TaskRoute) -> NavigationTransition {
        let taskViewController = ATYCreateTaskViewController()
        taskViewController.hidesBottomBarWhenPushed = true
        
        
        switch route {
        case .add:
            let addTaskViewController = ATYAddTaskViewController()
            let addTaskViewModel = AddTaskViewModelImpl(router: unownedRouter)
            prepare(viewController: addTaskViewController, with: addTaskViewModel)
            return .present(addTaskViewController, animation: nil)
            
        case .addCourseTask(let task):
            guard let topViewController = self.rootViewController.topViewController else {
                return .none()
            }
            let addTaskCoordinator = AddTaskSheetCoordinator(rootViewController: topViewController, taskRouter: unownedRouter)
            
            addTaskCoordinator.timeReceiverChanged = { [weak self] reciever in
                self?.timeReceiver = reciever
            }
            
            addChild(addTaskCoordinator)
            return .route(.add(task: task), on: addTaskCoordinator)
            
        case .create(let taskType):
            switch mode {
            case .createUserTask:
                let factory = CreateTaskFactory(type: taskType, mode: mode)
                prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
                
            case .createCourseTask(let id):
                let factory = CreateCourseTaskFactory(courseId: id, type: taskType, mode: mode)
                prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
                
            case .editUserTask(let task):
                let factory = EditUserTaskFactory(task: task, mode: mode)
                prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
                
            default:
                return .none()
            }
            return .multiple([
                .dismiss(),
                .push(taskViewController)
            ])
            
        case .adminEdit(let courseName, let courseTask):
            let factory = AdminEditCourseTaskFactory(courseName: courseName, courseTask: courseTask, mode: mode)
            prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
            return .push(taskViewController)
            
        case .courseTaskEdit(let userTask):
            let factory = UsereditCourseTaskFactory(task: userTask, mode: mode)
            prepare(viewController: taskViewController, with: factory.getViewModel(unownedRouter))
            return .push(taskViewController)
            
        case .timePicker(let type):
            guard let topController = rootViewController.topViewController else {
                return .none()
            }
            let timePickerCoordinator = TimePickerCoordinator(
                type: type,
                pickerDelegate: timeReceiver,
                rootViewController: topController
            )
            addChild(timePickerCoordinator)
            return .none()
            
        case .done:
            return .pop()
        }
    }
    
    private func prepare<T: BindableType>(viewController: T, with viewModel: T.ViewModelType) where T: UIViewController {
        viewController.bind(to: viewModel)
        
        guard let input = viewModel as? TimePickerDelegate else {
            return
        }
        timeReceiver = input
    }
    
}
