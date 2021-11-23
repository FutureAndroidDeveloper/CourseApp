import Foundation
import XCoordinator

enum RegistrationRoute: Route {
    case initial
    case credentials(mail: String, password: String)
    case name(_ name: String)
    case avatar(path: String?)
    case url(_ url: URL)
}


class RegistrationCoordinator: NavigationCoordinator<RegistrationRoute> {
    
    private let loginRouter: UnownedRouter<LoginRoute>
    
    init(loginRouter: UnownedRouter<LoginRoute>, rootViewController: RootViewController) {
        self.loginRouter = loginRouter
        super.init(rootViewController: rootViewController)
        trigger(.initial)
    }
    
    override func prepareTransition(for route: RegistrationRoute) -> NavigationTransition {
        configureContainer()
        
        switch route {
        case .initial:
            let registrationViewController = ATYRegistrationViewController()
            let viewModel = RegistrationViewModelImpl(router: unownedRouter)
            registrationViewController.bind(to: viewModel)
            return .push(registrationViewController)
            
        case .credentials(let mail, let password):
            // сохранить данные
            print("Coordinator did recieve creds: \(mail) : \(password)")
            let nameVc = ATYEnterNameViewController()
            let viewModel = EnterNameViewModelImpl(router: unownedRouter)
            nameVc.bind(to: viewModel)
            return .push(nameVc)
            
        case .name(let name):
            // создать запрос на создание
            print("Name recieved: \(name)")
            let photoVc = ATYAddPhotoViewController()
            let viewModel = AddPhotoViewModelImpl(router: unownedRouter)
            photoVc.bind(to: viewModel)
            return .push(photoVc)
            
        case .avatar(let path):
            // обновить модель, если есть путь
            print("Path received = \(path)")
            loginRouter.trigger(.didLogin)
            
        case .url(let url):
            UIApplication.shared.open(url)
        }
        
        return .none()
    }
    
    private func configureContainer() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        rootViewController.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
