import Foundation


/**
 Класс, предоствляющий модель прогресса задачи.
 */
class TaskProgressProvider {
    
    func convert(task: Task, for date: Date) -> TaskProgressModel {
        switch task.taskType {
        case .CHECKBOX, .TEXT, .TIMER:
            return IconProgressModel(task: task, date: date)
        case .RITUAL:
            return CountProgressModel(task: task, date: date)
        }
    }
    
}
