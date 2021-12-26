import Foundation


// Все, кто может валидировать значения
protocol Validating {
    associatedtype ValidatingError: ValidationError
    
    var hasError: Bool { get set }
    
    func bind(error: ValidatingError?, to receiver: ValidationErrorDisplayable)
}
