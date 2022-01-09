import XCoordinator


enum AddCourseTaskRoute: Route {
    case taskAdded
    case timePicker
    case sanctionQuestion
}


class AddTaskSheetCoordinator: ViewCoordinator<AddCourseTaskRoute> {
    private weak var timeReceiver: TimePickerDelegate?
    weak var flowDelegate: FlowEndHandlerDelegate?
    var taskDidAdd: (() -> Void)?
    
    init(task: CourseTaskResponse) {
        let addCourseTaskViewController = AddCourseTaskViewController()
        super.init(rootViewController: addCourseTaskViewController)
        
        let constructor = AddCourseTaskConstructor(model: AddCourseTaskModel())
        let addCourseTaskViewModel = AddCourseTaskViewModelImpl(courseTask: task, constructor: constructor, addTaskRouter: unownedRouter)
        addCourseTaskViewController.bind(to: addCourseTaskViewModel)
        timeReceiver = addCourseTaskViewModel
    }
    
    override func prepareTransition(for route: AddCourseTaskRoute) -> ViewTransition {
        switch route {
        case .taskAdded:
            flowDelegate?.flowDidEnd()
            taskDidAdd?()
            return .none()
            
        case .timePicker:
            let timePickerCoordinator = TimePickerCoordinator(type: .userTaskDuration, pickerDelegate: timeReceiver)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: timePickerCoordinator)
            timePickerCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
            
        case .sanctionQuestion:
            let infoCoordinator = UserInfoNotificationCoordinator(notification: .failureSanction)
            let bottomSheetCoordinator = BottomSheetCoordinator(content: infoCoordinator)
            infoCoordinator.flowDelegate = bottomSheetCoordinator
            return .present(bottomSheetCoordinator)
        }
    }
    
}
