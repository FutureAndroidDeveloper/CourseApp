import Foundation
import RealmSwift


enum TaskType: String, ValueComparable, PersistableEnum, Codable {
    case CHECKBOX, TEXT, TIMER, RITUAL
    
    var comparableValue: Int {
        switch self {
        case .CHECKBOX:
            return 100
        case .TEXT:
            return 200
        case .TIMER:
            return 400
        case .RITUAL:
            return 300
        }
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.comparableValue < rhs.comparableValue
    }
}
