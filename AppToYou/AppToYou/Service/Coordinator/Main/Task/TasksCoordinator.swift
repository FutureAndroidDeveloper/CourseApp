import Foundation
import XCoordinator

enum TasksRoute: Route {
    case tasks
    case add
    case create(ATYTaskType)
    case timePicker
}

// Разбить координатор на отдельные
class TasksCoordinator: NavigationCoordinator<TasksRoute> {
    
    private var createTaskViewModel: CreateTaskViewModel?
    
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
            print("Type = \(taskType.title)")
            let vc = ATYCreateTaskViewController()
            vc.hidesBottomBarWhenPushed = true
            let vm = CreateTaskViewModelImpl(taskType: taskType, router: unownedRouter)
            createTaskViewModel = vm
            vc.bind(to: vm)
            
            return .multiple([
                .dismiss(),
                .push(vc)
            ])
            
        case .timePicker:
            let timePicker = ATYSelectTimeViewController()
            timePicker.callBackTime = { [weak self] (hour, minute) in
                let time = NotificationTime(hour: hour, min: minute)
                self?.createTaskViewModel?.input.notificationTimePicked(time)
            }

            return .present(timePicker, animation: nil)
        }
    }
    
//    func test() {
//        let child = ATYAddTaskViewController()
//        let vc = ATYCreateTaskViewController()
//        vc.hidesBottomBarWhenPushed = true
//
//        child.pushVcCallback = { [weak self] type in
//            vc.types = type
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
//
//        self.transition = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
//
//        child.transitioningDelegate = transition   // 2
//        child.modalPresentationStyle = .custom  // 3
//
//        present(child, animated: true)
//    }
    
    
    private func configureContainer() {
        rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tasks(),
                                                     image: R.image.targetNotActive(),
                                                     selectedImage: R.image.targetActive())
    }
    
}
