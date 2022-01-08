import Foundation

enum TimePickerType {
    case userTaskDuration
    case courseTaskDuration
    case course
    case notification
    
    var title: String? {
        switch self {
        case .userTaskDuration, .courseTaskDuration, .course:
            return "Выбрать длительность"
        case .notification:
            return "Добавить напоминание"
        }
    }
    
    var components: Int {
        switch self {
        case .userTaskDuration, .courseTaskDuration, .course:
            return 3
        case .notification:
            return 0
        }
    }
    
    func getNumberOfRows(for component: Int) -> Int {
        switch component {
        case 0:
            switch self {
            case .userTaskDuration: return 24
            case .courseTaskDuration, .course: return 31
            default: return 0
            }
        case 1:
            switch self {
            case .userTaskDuration: return 60
            case .courseTaskDuration, .course: return 12
            default: return 0
            }
        case 2:
            switch self {
            case .userTaskDuration: return 60
            case .courseTaskDuration, .course: return 31
            default: return 0
            }
        default:
            return 0
        }
    }
}
