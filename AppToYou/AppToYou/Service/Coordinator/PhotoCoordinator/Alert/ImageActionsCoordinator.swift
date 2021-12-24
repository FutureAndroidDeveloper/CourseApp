import UIKit
import XCoordinator


enum ImageActionRoute: Route {
    case showImagePicker(source: UIImagePickerController.SourceType)
    case openImage
    case remove
}


class ImageActionsCoordinator: RedirectionRouter<PhotoRoute, ImageActionRoute> {
    
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    
    init(parent: UnownedRouter<PhotoRoute>) {
        super.init(viewController: alertController, parent: parent, map: nil)
        configure()
    }
    
    override func mapToParentRoute(_ route: ImageActionRoute) -> PhotoRoute {
        switch route {
        case .openImage:
            return .detailed
            
        case .showImagePicker(let source):
            return .picker(source: source)
            
        case .remove:
            return .remove
        }
    }
    
    private func configure() {
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = R.color.backgroundAppColor()
        alertController.view.tintColor = R.color.buttonColor()

        let openAction = UIAlertAction(title: "Просмотреть", style: .default) { [weak self] _ in
            self?.trigger(.openImage)
        }
        openAction.setValue(R.image.vIc_vision(), forKey: "image")
        alertController.addAction(openAction)
        
        let takePhotoAction = UIAlertAction(title: "Сделать фото", style: .default) { [weak self] _ in
            self?.trigger(.showImagePicker(source: .camera))
        }
        takePhotoAction.setValue(R.image.vIc_takePhoto(), forKey: "image")
        alertController.addAction(takePhotoAction)
        
        let libraryAction = UIAlertAction(title: "Загрузить из галлереи", style: .default) { [weak self] _ in
            self?.trigger(.showImagePicker(source: .photoLibrary))
        }
        libraryAction.setValue(R.image.vIc_gallery(), forKey: "image")
        alertController.addAction(libraryAction)
        
        let removeAction = UIAlertAction(title: "Удалить фото", style: .destructive) { _ in
            self.trigger(.remove)
        }
        removeAction.setValue(R.image.vIc_trash(), forKey: "image")
        alertController.addAction(removeAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
    }
    
}
