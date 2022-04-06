import XCoordinator


enum CountPickerRoute: Route {
    case countPicked
}


class CountPickerCoordinator: ViewCoordinator<CountPickerRoute> {
    weak var flowDelegate: FlowEndHandlerDelegate?
    
    init(task: Task, result: RealmTaskResult, change: CountChange) {
        let countPickerViewController = ChangeCounterViewController()
        super.init(rootViewController: countPickerViewController)
        
        let countPickerViewModel = ChangeCounterViewModelImpl(task: task, result: result, changeType: change, router: unownedRouter)
        countPickerViewController.bind(to: countPickerViewModel)
    }
    
    override func prepareTransition(for route: CountPickerRoute) -> ViewTransition {
        switch route {
        case .countPicked:
            flowDelegate?.flowDidEnd()
        }
        return .none()
    }
    
}
