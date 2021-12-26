import Foundation


enum CourseError: ValidationError {
    case name(common: CommonValidationError.Name)
    case description(common: CommonValidationError.Description)
    case duration(common: CommonValidationError.Duration)
    
    case categories
    case payment
    case link
    
    var message: String? {
        switch self {
        case .name(let common):
            return common.message
        case .description(let common):
            return common.message
        case .duration(let common):
            return common.message
            
        case .categories:
            return "Укажите 3 категории курса"
        case .payment:
            return "Укажите оплату за вступление"
        case .link:
            return "Проверьте ссылку"
        }
    }
    
}
