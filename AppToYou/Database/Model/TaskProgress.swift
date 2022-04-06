import Foundation
import RealmSwift


enum TaskProgress: String, ValueComparable, PersistableEnum {
    case notStarted, inProgress, done, failed
    
    var comparableValue: Int {
        switch self {
        case .notStarted:
            return 300
        case .inProgress:
            return 400
        case .done:
            return 200
        case .failed:
            return 100
        }
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.comparableValue < rhs.comparableValue
    }
}
