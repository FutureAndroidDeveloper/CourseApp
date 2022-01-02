import Foundation
import XCoordinator


enum TaskRoute: Route {
    case add
    case create(ATYTaskType)
    case timePicker(type: TimePickerType)
}


class TaskCoordinator: NavigationCoordinator<TaskRoute> {
    
    private weak var createTaskInput: CreateTaskViewModelInput?
    private let mode: CreateTaskMode
    
    init(mode: CreateTaskMode, rootViewController: RootViewController) {
        self.mode = mode
        super.init(rootViewController: rootViewController)
        trigger(.add)
    }
    
    override func prepareTransition(for route: TaskRoute) -> NavigationTransition {
        switch route {
        case .add:
            let vc = ATYAddTaskViewController()
            let vm = AddTaskViewModelImpl(router: unownedRouter)
            vc.bind(to: vm)
            
            return .present(vc, animation: nil)
            
        case .create(let taskType):
            let createTaskViewController = ATYCreateTaskViewController()
            var viewModel: CreateTaskViewModel
            
            switch mode {
            case .createUserTask:
                let factory = CreateTaskFactory(type: taskType, mode: mode)
                viewModel = factory.getViewModel(unownedRouter)
                
            case .createCourseTask:
                let factory = CreateCourseTaskFactory(type: taskType, mode: mode)
                viewModel = factory.getViewModel(unownedRouter)
                
            case .editUserTask, .editCourseTask, .adminEditCourseTask:
                return .none()
            }
            
            createTaskInput = viewModel.input
            createTaskViewController.bind(to: viewModel)
            createTaskViewController.hidesBottomBarWhenPushed = true
            
            return .multiple([
                .dismiss(),
                .push(createTaskViewController)
            ])
            
        case .timePicker(let type):
            let timePickerCoordinator = TimePickerCoordinator(type: type,
                                                              pickerDelegate: createTaskInput,
                                                              rootViewController: self.rootViewController)
            addChild(timePickerCoordinator)
            return .none()
        }
    }
    
}
