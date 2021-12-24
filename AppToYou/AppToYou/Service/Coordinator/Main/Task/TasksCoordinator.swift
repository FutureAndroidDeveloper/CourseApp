import Foundation
import XCoordinator

enum TasksRoute: Route {
    case tasks
    case add
    case create(ATYTaskType)
    case timePicker(type: TimePickerType)
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
            let vc = NavigationBarViewController(taskRouter: unownedRouter)
            return .push(vc)
            
        case .add:
            let vc = ATYAddTaskViewController()
            let vm = AddTaskViewModelImpl(router: unownedRouter)
            vc.bind(to: vm)
            
            return .present(vc, animation: nil)
            
        case .create(let taskType):
            let factory = CreateTaskFactory(type: taskType)
            let viewModel = factory.getViewModel(unownedRouter)
            createTaskInput = viewModel.input
            
            let vc = ATYCreateTaskViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.bind(to: viewModel)
            
            return .multiple([
                .dismiss(),
                .push(vc)
            ])
            
        case .timePicker(let type):
            let timePickerCoordinator = TimePickerCoordinator(type: type,
                                                              pickerDelegate: createTaskInput,
                                                              rootViewController: self.rootViewController)
            addChild(timePickerCoordinator)
            return .none()
        }
    }
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tasks(),
                                                     image: R.image.targetNotActive(),
                                                     selectedImage: R.image.targetActive())
    }
    
}
