import Foundation


/**
 Класс, предоствляющий модель с дополнительной информацией о задаче.
 
 Модель может включать в себя навазние курса и стоимость задачи.
 */
class TaskHintProvider {
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    func convert(task: Task) -> CourseTaskHintModel? {
        var title: String?
        var currency: CourseTaskCurrency = .free
        
        if task.taskSanction > .zero {
            currency = .coin
        }
        
        if let courseName = task.courseName {
            title = courseName
        }
        
        return CourseTaskHintModel(title: title, currency: currency)
    }
    
}
