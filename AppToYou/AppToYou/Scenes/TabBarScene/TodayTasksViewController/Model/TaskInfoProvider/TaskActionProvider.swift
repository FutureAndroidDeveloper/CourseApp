import Foundation


/**
 Класс, предоствляющий модель действий над задачей.
 */
class TaskActionProvider {
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    func convert(task: Task, date: Date) -> TaskActionModel? {
        switch task.taskType {
        case .CHECKBOX, .TEXT:
            return nil
            
        case .RITUAL:
            return TaskCounterActionModel(task: task, date: date)
            
        case .TIMER:
            return TaskTimerActionModel(task: task, date: date)
        }
    }
}
