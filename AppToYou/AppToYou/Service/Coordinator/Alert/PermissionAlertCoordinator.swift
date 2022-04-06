import UIKit
import XCoordinator


enum PermissionRoute: Route {
    
}


class PermissionAlertCoordinator: ViewCoordinator<PermissionRoute> {
    
    private let alertController = UIAlertController(title: "Нет доступа", message: "Перейдите в настройки", preferredStyle: .alert)
    
    init() {
        super.init(rootViewController: alertController)
        configure()
    }
    
    private func configure() {
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        alertController.addAction(settingsAction)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
    }
    
}
