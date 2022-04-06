import Foundation
import RealmSwift


enum Frequency: String, PersistableEnum, Codable {
    case ONCE, EVERYDAY, WEEKDAYS, MONTHLY, YEARLY, CERTAIN_DAYS
}
