import Foundation


class TaskHintProvider {
    
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    func convert(task: UserTaskResponse) -> CourseTaskHintModel? {
        guard let courseName = task.courseName else {
            return nil
        }
        return CourseTaskHintModel(title: courseName, currency: .coin)
    }
    
}
