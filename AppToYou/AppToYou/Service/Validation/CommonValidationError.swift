import Foundation

/**
 Общие ошибки полей
 */
struct CommonValidationError {
    
    enum Name: ValidationError {
        case name
        case nameLength
        
        var message: String? {
            switch self {
            case .name:
                return "Укажите название"
            case .nameLength:
                return "Название не более 63 символов"
            }
        }
        
    }
    
    enum Sanction: ValidationError {
        case sanction
        case lessThanMin(value: Int)
        
        var message: String? {
            switch self {
            case .sanction:
                return "Введите штраф за невыполнение или откючите поле"
            case .lessThanMin(let value):
                return "Штраф не может быть меньше \(value)"
            }
        }
    }
    
    enum Description: ValidationError {
        case description
        case descriptionLength
        
        var message: String? {
            switch self {
            case .description:
                return "Укажите описание"
            case .descriptionLength:
                return "Описание не более 255 символов"
            }
        }
    }
    
    enum Duration: ValidationError {
        case duration
        
        var message: String? {
            switch self {
            case .duration:
                return "Укажите длительность"
            }
        }
    }
}
