import UIKit
import XCoordinator


enum PhotoRoute: Route {
    case actions
    case picker(source: UIImagePickerController.SourceType)
    case detailed
    case remove
    
    case picked(image: UIImage?, path: String?)
    case error(message: String)
}


class PhotoCoordinator: NavigationCoordinator<PhotoRoute> {
    
    private var image: UIImage?
    private weak var photoDelegate: PhotoDelegate?
    
    
    init(image: UIImage?, photoDelegate: PhotoDelegate?, rootViewController: RootViewController) {
        self.image = image
        self.photoDelegate = photoDelegate
        super.init(rootViewController: rootViewController)
        trigger(.actions)
    }
    
    override func prepareTransition(for route: PhotoRoute) -> NavigationTransition {
        switch route {
        case .actions:
            let actionCoordinator = ImageActionsCoordinator(parent: unownedRouter)
            return .present(actionCoordinator)
            
        case .picker(let source):
            var toPresent: Presentable
            
            if UIImagePickerController.isSourceTypeAvailable(source) {
                toPresent = ImagePickerCoordinator(source: source, parent: unownedRouter)
            } else {
                toPresent = PermissionAlertCoordinator()
            }
            return .present(toPresent)
            
        case .detailed:
            guard let photo = image else {
                return .none()
            }
            let detailedImageViewController = ATYDetailImageViewController(image: photo)
            return .present(detailedImageViewController)
            
        case .remove:
            self.photoDelegate?.photoPicked(nil, with: nil)
            return .dismiss()
            
        case .picked(let image, let path):
            self.photoDelegate?.photoPicked(image, with: path)
            return .dismiss()
            
        case .error(let message):
            let errorAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            return .present(errorAlert)
        }
    }
    
}
