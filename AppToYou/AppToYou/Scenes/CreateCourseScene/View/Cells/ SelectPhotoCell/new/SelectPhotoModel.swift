import UIKit


class SelectPhotoModel {
    
    private(set) var photoImage: UIImage?
    private(set) var path: String?
    let defaultImage: UIImage?
    let pickImage: (() -> Void)
    
    init(photoImage: UIImage?, defaultImage: UIImage?, pickImage: @escaping () -> Void) {
        self.photoImage = photoImage
        self.defaultImage = defaultImage
        self.pickImage = pickImage
        update(image: photoImage)
    }
    
    func update(image: UIImage?, path: String? = nil) {
        self.path = path
        photoImage = image ?? defaultImage
    }
    
}
