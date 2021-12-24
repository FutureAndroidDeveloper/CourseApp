import Foundation


enum CreateCourseMode {
    case creation
    case editing
    
    var title: String? {
        switch self {
        case .creation:
            return "Создание нового курса"
        case .editing:
            return "Редактирование"
        }
    }
    
    var doneTitle: String? {
        switch self {
        case .creation:
            return "Создать курс"
        case .editing:
            return "Сохранить"
        }
    }
    
}
