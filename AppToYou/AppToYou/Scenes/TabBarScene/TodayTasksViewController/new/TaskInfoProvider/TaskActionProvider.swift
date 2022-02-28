import Foundation


class TaskActionProvider {
    
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    func convert(task: UserTaskResponse) -> TaskAction? {
        switch task.taskType {
        case .CHECKBOX:
            return nil
        case .TEXT:
            return nil
        case .RITUAL:
            return TaskCounterActionModel()
        case .TIMER:
            let attribute = task.taskAttribute ?? String()
            var hour = 0
            var min = 0
            var sec = 0
            
            attribute.split(separator: Constants.timeSeparator)
                .enumerated()
                .forEach { item in
                    let value = Int(item.element) ?? .zero

                    switch item.offset {
                    case 0: hour = value
                    case 1: min = value
                    case 2: sec = value
                    default: break
                    }
                }

            let duration = TaskDuration(hour: hour, min: min, sec: sec)
            let timerModel = TaskTimerModel(duration: duration)
            return TaskTimerActionModel(timerModel: timerModel)
        }
    }
    
}
