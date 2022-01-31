import Foundation
import XCoordinator

enum RegistrationRoute: Route {
    case credentials
    case name(_ credentials: Credentials)
    case profileImage
    
    case photo(_ image: UIImage?)
    case haveAccount
    case didRegister
    case url(_ url: URL)
    case error(message: String)
}


class RegistrationCoordinator: NavigationCoordinator<RegistrationRoute> {
    
    private let loginRouter: UnownedRouter<LoginRoute>
    private weak var photoReceiver: PhotoDelegate?
    
    init(loginRouter: UnownedRouter<LoginRoute>, rootViewController: RootViewController) {
        self.loginRouter = loginRouter
        super.init(rootViewController: rootViewController)
        trigger(.credentials)
    }
    
    override func prepareTransition(for route: RegistrationRoute) -> NavigationTransition {
        configureContainer()
        
        switch route {
        case .credentials:
            let registrationViewController = ATYRegistrationViewController()
            let viewModel = RegistrationViewModelImpl(router: unownedRouter)
            registrationViewController.bind(to: viewModel)
            return .push(registrationViewController)
            
        case .name(let credentials):
            let nameViewController = ATYEnterNameViewController()
            let nameViewModel = EnterNameViewModelImpl(credentials: credentials, router: unownedRouter)
            nameViewController.bind(to: nameViewModel)
            return .push(nameViewController)
            
        case .profileImage:
            let photoVc = ProfilePhotoViewController()
            let viewModel = AddPhotoViewModelImpl(router: unownedRouter)
            photoVc.bind(to: viewModel)
            photoReceiver = viewModel
            return .push(photoVc)
            
        case .photo(let image):
            let photoCoordinator = PhotoCoordinator(image: image,
                                                    photoDelegate: photoReceiver,
                                                    rootViewController: self.rootViewController)
            addChild(photoCoordinator)
            return .none()
            
        case .didRegister:
            loginRouter.trigger(.didLogin)
            
        case .haveAccount:
            return .pop()
            
        case .url(let url):
            UIApplication.shared.open(url)
            
        case .error(let message):
            let errorCoordinator = ErrorAlertCoordinator(message: message)
            return .present(errorCoordinator)
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
