import Foundation
import XCoordinator


enum UserInfoRoute: Route {
    case done
    case pay
    case payLater
}


class UserInfoNotificationCoordinator: ViewCoordinator<UserInfoRoute> {
    private let notification: UserInfoNotification
    weak var flowDelegate: FlowEndHandlerDelegate?
    
    var addAllTasksDidTap: (() -> Void)?
    
    init(notification: UserInfoNotification) {
        self.notification = notification
        
        let infoViewController = InfoViewController()
        super.init(rootViewController: infoViewController)
        
        let constructor = InfoModelConstructor(notification: notification, infoModel: InfoModel())
        let infoViewModel = InfoViewModelImpl(notification: notification, constructor: constructor, infoRouter: unownedRouter)
        infoViewController.bind(to: infoViewModel)
    }
    
    override func prepareTransition(for route: UserInfoRoute) -> ViewTransition {
        switch route {
        case .done:
            if case .allCourseTasksAdded = notification {
                addAllTasksDidTap?()
            }
            flowDelegate?.flowDidEnd()
            
        case .pay:
            flowDelegate?.flowDidEnd()
            
        case .payLater:
            flowDelegate?.flowDidEnd()
        }
        
        return .none()
    }
    
}
