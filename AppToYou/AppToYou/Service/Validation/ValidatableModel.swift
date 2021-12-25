import Foundation


// Любоя модель, которая используется для привязки данных к UI, должна принимать этот протокол
// для возможности принимать ошибку валидации и передавать в UI.
protocol ValidatableModel: ValidationErrorNotification, ValidationErrorDisplayable {
    
}


// Реализация по умолчанию передачи ошибки из модели в UI
extension ValidatableModel {
    
    func bind(error: ValidationError?) {
        let castedError = error as? NotificationError
        errorNotification?(castedError)
    }
    
}
