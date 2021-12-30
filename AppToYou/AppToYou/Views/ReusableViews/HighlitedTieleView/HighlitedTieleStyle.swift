import UIKit


enum HighlitedTieleStyle {
    case courseName
    case taskName
    
    var titleColor: UIColor? {
        switch self {
        case .courseName:
            return R.color.backgroundTextFieldsColor()
        case .taskName:
            return R.color.titleTextColor()
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .courseName:
            return R.color.textColorSecondary()
        case .taskName:
            return R.color.cardsColor()
        }
    }
    
}
