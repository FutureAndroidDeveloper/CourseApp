import UIKit


protocol InflatableView {
    static var staticHeight: CGFloat? { get }
    
    func inflate(model: AnyObject)
}


extension InflatableView {
    static var staticHeight: CGFloat? {
        return nil
    }
}
