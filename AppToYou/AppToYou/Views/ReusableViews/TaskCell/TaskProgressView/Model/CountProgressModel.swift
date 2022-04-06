import Foundation


/**
 Модель прогресса для задачи подсчета повторений.
 */
class CountProgressModel: TaskProgressModel {
    private struct Constants {
        static let defaultCount = "0"
    }
    
    /**
     Получить количество выполненных повторов.
     */
    override func getProgressValue() -> Any? {
        var count = Constants.defaultCount
        
        switch type {
        case .RITUAL:
            count = result?.result ?? Constants.defaultCount
        default:
            break
        }
        
        let result = count.isEmpty ? Constants.defaultCount : count
        return result
    }
}
