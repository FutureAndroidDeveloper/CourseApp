import UIKit
import XCoordinator


class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private struct Constants {
        static let compressionQuality: CGFloat = 0.25
        static let fileExtension = "png"
    }
    
    private let pickerRouter: UnownedRouter<ImagePickerRoute>

    
    init(pickerRouter: UnownedRouter<ImagePickerRoute>) {
        self.pickerRouter = pickerRouter
        super.init()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        didSelect(image: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            didSelect(image: nil)
            return
        }
        
        guard let docDir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            showError(message: "Couldn't get document directory for file")
            return
        }
        
        let imageUniqueName: Int64 = Int64(NSDate().timeIntervalSince1970 * 1000);
        let filePathComponent = "\(imageUniqueName).\(Constants.fileExtension)"
        let filePath = docDir.appendingPathComponent(filePathComponent)
        
        do {
            // сжатие картинки и запись сжатой на диск?
            if let imageData = image.jpegData(compressionQuality: Constants.compressionQuality) {
                try imageData.write(to: filePath, options: .atomic)
            }
        } catch {
            showError(message: "Couldn't write image")
        }
        didSelect(image: image, with: filePathComponent)
    }
    
    private func didSelect(image: UIImage?, with path: String? = nil) {
        pickerRouter.trigger(.picked(image: image, path: path))
    }
    
    private func showError(message: String) {
        pickerRouter.trigger(.error(message: message))
    }
    
}
