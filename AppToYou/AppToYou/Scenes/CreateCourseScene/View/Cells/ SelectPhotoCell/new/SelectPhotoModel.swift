import UIKit


class SelectPhotoModel {
    private(set) var photoImage: UIImage?
    
    init(photoImage: UIImage?) {
        self.photoImage = photoImage
    }
    
    func update(image: UIImage?) {
        photoImage = image
    }
    
}
