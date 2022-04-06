
import XCoordinator


enum ErrorRoute: Route {
    
}


class ErrorAlertCoordinator: ViewCoordinator<ErrorRoute> {
    
    private let alertController = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
    
    init(message: String) {
        super.init(rootViewController: alertController)
        alertController.message = message
        alertController.addAction(.init(title: "Ok", style: .cancel, handler: nil))
    }
    
}
