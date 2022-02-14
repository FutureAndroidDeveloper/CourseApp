import UIKit


enum CalendarDayProgress {
    case complete
    case failed
    case inProgress
    case notStarted
    case future
    
    var color: UIColor? {
        switch self {
        case .complete: return R.color.succesColor()
        case .failed: return R.color.failureColor()
        case .inProgress: return R.color.textColorSecondary()
        case .notStarted: return R.color.textSecondaryColor()
        case .future: return .clear
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .complete, .failed, .inProgress:
            return color
        case .notStarted, .future:
            return R.color.textColorSecondary()
        }
    }
        
}
