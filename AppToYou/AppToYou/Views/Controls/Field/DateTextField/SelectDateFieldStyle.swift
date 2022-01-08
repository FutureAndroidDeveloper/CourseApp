import UIKit


struct FieldStyle {
    let backgroundColor: UIColor?
    let textColor: UIColor?
}

class StyleManager {
    
    static let shared = StyleManager()
    
    private init() {
        
    }
    
    static let standartTextField = FieldStyle(backgroundColor: R.color.backgroundTextFieldsColor(),
                                              textColor: R.color.titleTextColor())
    
    static let highlightedTextField = FieldStyle(backgroundColor: R.color.textColorSecondary(),
                                                 textColor: R.color.backgroundTextFieldsColor())
    
    static let reversedcolorsTextField = FieldStyle(backgroundColor: R.color.backgroundAppColor(),
                                                    textColor: R.color.titleTextColor())
}

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
