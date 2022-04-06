import XCoordinator
import UIKit


enum TextAnswerRoute: Route {
    case initial
    case done
}


class TextAnswerCoordinator: NavigationCoordinator<TextAnswerRoute> {
    private let task: Task
    private let result: RealmTaskResult
    
    init(task: Task, result: RealmTaskResult, rootViewController: RootViewController) {
        self.task = task
        self.result = result
        super.init(rootViewController: rootViewController)
        trigger(.initial)
    }
    
    override func prepareTransition(for route: TextAnswerRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let textAnswerViewController = TextAnswerViewController()
            let textAnswerViewModel = TextAnswerViewModelImlp(task: task, result: result, router: unownedRouter)
            
            textAnswerViewController.bind(to: textAnswerViewModel)
            textAnswerViewController.hidesBottomBarWhenPushed = true
            return .push(textAnswerViewController)
            
        case .done:
            return .pop()
        }
    }
    
}
