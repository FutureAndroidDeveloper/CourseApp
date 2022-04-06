import UIKit


enum CourseTaskCurrency: String, Encodable {
    case coin
    case diamond
    case free
    
    var icon: UIImage? {
        switch self {
        case .coin:
            return R.image.coinImage()
        case .diamond:
            return R.image.diamondImage()
        case .free:
            return nil
        }
    }
}
