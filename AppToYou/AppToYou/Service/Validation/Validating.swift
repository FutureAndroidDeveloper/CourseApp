import Foundation


// Все, кто может валидировать значения
protocol Validating {
    associatedtype ValidatingError: ValidationError
    
    var hasError: Bool { get }
    
    func bind(error: ValidatingError?, to receiver: ValidationErrorDisplayable)
}
