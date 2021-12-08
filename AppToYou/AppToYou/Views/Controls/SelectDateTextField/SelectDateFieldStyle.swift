import UIKit


enum SelectDateFieldStyle {
    case standart
    case highlighted
    
    var backgroundColor: UIColor? {
        switch self {
        case .standart:
            return R.color.backgroundTextFieldsColor()
        case .highlighted:
            return R.color.textColorSecondary()
        }
    }
    
    var textColor: UIColor? {
        switch self {
        case .standart:
            return R.color.titleTextColor()
        case .highlighted:
            return R.color.backgroundTextFieldsColor()
        }
    }
    
    var imageColor: UIColor? {
        switch self {
        case .standart:
            return R.color.textSecondaryColor()
        case .highlighted:
            return R.color.backgroundTextFieldsColor()
        }
    }
    
}
