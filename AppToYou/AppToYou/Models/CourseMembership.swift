import Foundation


enum CourseMembership: String, CaseIterable {
    case all
    case admin
    case member
    case request
    
    var title: String? {
        switch self {
        case .all:
            return "Все"
        case .admin:
            return "Мои курсы"
        case .member:
            return "Учавствую в курсе"
        case .request:
            return "Заявка подана"
        }
    }
}


class MyTestClass {
    func test() {
        
    }
}
