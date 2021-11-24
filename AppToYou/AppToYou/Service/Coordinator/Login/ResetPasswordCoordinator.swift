import Foundation
import XCoordinator

enum ResetPasswordRoute: Route {
    case enterEmail
    case checkEmail
    case newPassword(token: String)
    case openMailClient
    case login
}


class ResetPasswordCoordinator: NavigationCoordinator<ResetPasswordRoute> {
        
    init(rootViewController: RootViewController) {
        super.init(rootViewController: rootViewController)
        trigger(.enterEmail)
    }
    
    override func prepareTransition(for route: ResetPasswordRoute) -> NavigationTransition {
        configureContainer()
        
        switch route {
        case .enterEmail:
            let forgotPasswordViewController = ATYForgotPasswordViewController()
            let forgotPasswordViewModel = ForgotPasswordViewModelImpl(router: unownedRouter)
            forgotPasswordViewController.bind(to: forgotPasswordViewModel)
            
            return .push(forgotPasswordViewController)
            
        case .checkEmail:
            let checkEmailViewController = CheckEmailViewController()
            let checkEmailViewModel = CheckEmailViewModelImpl(router: unownedRouter)
            checkEmailViewController.bind(to: checkEmailViewModel)
            
            return .push(checkEmailViewController)
            
        case .newPassword(let token):
            // TODO: Handle DeepLink from closed and existing App
            
            let newPasswordViewController = NewPasswordViewController()
            let newPasswordViewModel = NewPasswordViewModelImpl(token: token, router: unownedRouter)
            newPasswordViewController.bind(to: newPasswordViewModel)
            
            return .push(newPasswordViewController)
            
        case .login:
            return .multiple([
                .dismissToRoot(),
                .popToRoot()
            ])
            
        case .openMailClient:
            // TODO: Replace URL DeepLink with Dynamic Link
            
            let mailURL = URL(string: "message://")!
            if UIApplication.shared.canOpenURL(mailURL) {
                UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
            }
            trigger(.newPassword(token: ""))
            return .none()
        }
    }
    
    private func configureContainer() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        rootViewController.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
