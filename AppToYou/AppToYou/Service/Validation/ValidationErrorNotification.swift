import Foundation


// Все, кто может реагировать на получение ошибки
// Используется для уведомдения UI
protocol ValidationErrorNotification {
    associatedtype NotificationError: ValidationError
    
    var errorNotification: ((NotificationError?) -> Void)? { get }
}
