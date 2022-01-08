import UIKit


enum Opacity {
    
    private struct Constants {
        static let enabledOpacity: CGFloat = 0
        static let diabledOpacity: CGFloat = 0.6
        
        static let opacityViewTag = 12_48_93_54
        static let opacityColor = R.color.backgroundAppColor()
    }
    
    case enabled
    case disabled
    
    var value: CGFloat {
        switch self {
        case .enabled:
            return Constants.enabledOpacity
        case .disabled:
           return Constants.diabledOpacity
        }
    }
    
    var color: UIColor? {
        return Constants.opacityColor
    }
    
    var tag: Int {
        return Constants.opacityViewTag
    }
    
}
