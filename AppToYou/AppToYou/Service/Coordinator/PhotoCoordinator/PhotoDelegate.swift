import UIKit


protocol PhotoDelegate: AnyObject {
    func photoPicked(_ image: UIImage?, with path: String?)
}
