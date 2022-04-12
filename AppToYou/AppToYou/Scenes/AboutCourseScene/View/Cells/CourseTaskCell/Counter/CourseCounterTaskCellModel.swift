import Foundation


class CourseCounterTaskCellModel: CourseTaskCellModel {
    override init?(courseTaskResponse: CourseTaskResponse, isSelected: Bool = false) {
        super.init(courseTaskResponse: courseTaskResponse, isSelected: isSelected)
        guard let task = task else {
            return nil
        }
        progressModel = CountProgressModel(task: task, date: .distantFuture)
    }
}
