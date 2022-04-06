import Foundation
import UIKit


protocol Drawable {
    associatedtype Value: CustomStringConvertible
    
    func draw(value: Value)
}

extension UIView: Drawable {
    func draw(value: Int) {
        let repeatCountLayer = LCTextLayer()
        repeatCountLayer.string = "\(value)"
        
        let font = UIFont.systemFont(ofSize: 26)
        repeatCountLayer.font = font
        repeatCountLayer.fontSize = font.pointSize
        
        repeatCountLayer.alignmentMode = .center
        repeatCountLayer.rasterizationScale = UIScreen.main.scale
        repeatCountLayer.contentsScale = UIScreen.main.scale
        repeatCountLayer.foregroundColor = R.color.backgroundTextFieldsColor()?.cgColor
        
        
        repeatCountLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.bounds.size)
        repeatCountLayer.masksToBounds = true
        layer.insertSublayer(repeatCountLayer, at: 0)
    }
    
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}
