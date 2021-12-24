import UIKit
import XCoordinator


enum ImagePickerRoute: Route {
    case picked(image: UIImage?, path: String?)
    case error(message: String)
}


class ImagePickerCoordinator: RedirectionRouter<PhotoRoute, ImagePickerRoute> {
    
    private let pickerController = UIImagePickerController()
    private let source: UIImagePickerController.SourceType
    private var pickerDelegate: ImagePickerDelegate?
    
    private var unownedRouter: UnownedRouter<ImagePickerRoute> {
        UnownedRouter(self) { $0.strongRouter }
    }
    
    init(source: UIImagePickerController.SourceType, parent: UnownedRouter<PhotoRoute>) {
        self.source = source
        super.init(viewController: pickerController, parent: parent, map: nil)
        
        configure()
    }
    
    override func mapToParentRoute(_ route: ImagePickerRoute) -> PhotoRoute {
        switch route {
        case .picked(let image, let path):
            return .picked(image: image, path: path)
            
        case .error(let message):
            return .error(message: message)
        }
    }
    
    private func configure() {
        pickerDelegate = ImagePickerDelegate(pickerRouter: unownedRouter)
        pickerController.delegate = pickerDelegate
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = source
    }
    
}
