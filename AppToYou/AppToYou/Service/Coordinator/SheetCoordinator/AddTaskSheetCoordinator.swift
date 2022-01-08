import UIKit
import XCoordinator
import FittedSheets


enum AddCourseTaskRoute: Route {
    case add(task: CourseTaskResponse)
    case allAdded
    case taskAdded
}


class AddTaskSheetCoordinator: ViewCoordinator<AddCourseTaskRoute> {
    
    private let taskRouter: UnownedRouter<TaskRoute>
    
    var timeReceiverChanged: ((TimePickerDelegate) -> Void)?
    
    
    init(rootViewController: RootViewController, taskRouter: UnownedRouter<TaskRoute>) {
        self.taskRouter = taskRouter
        super.init(rootViewController: rootViewController)
    }
    
    override func prepareTransition(for route: AddCourseTaskRoute) -> ViewTransition {
        switch route {
        case .add(let task):
            let addCourseTaskViewController = AddCourseTaskViewController()
            let constructor = AddCourseTaskConstructor(model: AddCourseTaskModel())
            let addCourseTaskViewModel = AddCourseTaskViewModelImpl(courseTask: task, constructor: constructor, taskRouter: taskRouter)
            addCourseTaskViewController.bind(to: addCourseTaskViewModel)
            
            timeReceiverChanged?(addCourseTaskViewModel)
            
            let bottomSheetCoordinator = BottomSheetCoordinator(rootViewController: self.rootViewController)
            addChild(bottomSheetCoordinator)
            return .route(.show(addCourseTaskViewController), on: bottomSheetCoordinator)
            
        case .allAdded:
            return .none()
            
        case .taskAdded:
            return .none()
        }
    }
    
}
