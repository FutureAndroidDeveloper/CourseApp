import Foundation


/**
 Набор групп для задач.
 */
enum TaskFilter {
    /**
     Группа выполненных задач.
     */
    case finished
    
    /**
     Группа невыполненных задач.
     */
    case notFinished
    
    /**
     Проверить, что результат на опредленную дату соответствует группе.
     */
    func getCondition(for result: RealmTaskResult, date: Date) -> Bool {
        var conditionResult = false
        
        switch self {
        case .finished:
            conditionResult = result.date.starts(with: date.toString(dateFormat: .localeYearDate)) &&
            (result.progress == .done || result.progress == .failed)
            
        case .notFinished:
            conditionResult = result.date.starts(with: date.toString(dateFormat: .localeYearDate)) &&
            (result.progress == .notStarted || result.progress == .inProgress)
        }
        
        return conditionResult
    }
}
