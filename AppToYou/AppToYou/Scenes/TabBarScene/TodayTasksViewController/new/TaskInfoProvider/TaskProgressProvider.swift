import Foundation


class TaskProgressProvider {
    
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    func convert(task: UserTaskResponse, for date: Date) -> TaskProgressModel {
        guard let taskResult = getTaskResult(task: task, for: date) else {
            return TaskProgressModel(state: .failed, type: task.taskType)
        }
        
        var state: CurrentStateTask = .failed
        
        switch task.taskType {
        case .CHECKBOX:
            state = taskResult.isComplete ? .done : .didNotStart
            
        case .TEXT:
            state = taskResult.isComplete ? .done : .didNotStart
            
        case .RITUAL:
            let count = Int(taskResult.result) ?? .zero
            let aim = Int(task.taskAttribute ?? String()) ?? .zero
            
            if count == .zero, !taskResult.isComplete {
                state = .didNotStart
            } else if count > .zero, !taskResult.isComplete {
                state = .performed
            } else if taskResult.isComplete {
                state = .done
            } else if count < aim, !taskResult.isComplete {
                state = .failed
            }
            
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

            let passed = Int(taskResult.result) ?? .zero
            let aim = hour * 60 * 60 + min * 60 + sec
            
            if passed == .zero, !taskResult.isComplete {
                state = .didNotStart
            } else if passed > .zero, !taskResult.isComplete {
                state = .performed
            } else if taskResult.isComplete {
                state = .done
            } else if passed < aim, !taskResult.isComplete {
                state = .failed
            }
        }
        
        return TaskProgressModel(state: state, type: task.taskType)
    }
    
    private func getTaskResult(task: UserTaskResponse, for date: Date) -> TaskResult? {
        return task.taskResults?.first { result in
            guard let resultDate = result.date.localDateTime else {
                return false
            }
            return Calendar.current.isDate(resultDate, equalTo: date, toGranularity: .day)
        }
    }
    
}
