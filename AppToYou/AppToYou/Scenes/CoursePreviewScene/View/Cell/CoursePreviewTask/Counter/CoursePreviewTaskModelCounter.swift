import Foundation


class CoursePreviewTaskModelCounter: CoursePreviewTaskModel {
    override init?(courseTaskResponse: CourseTaskResponse) {
        super.init(courseTaskResponse: courseTaskResponse)
        guard let task = task else {
            return
        }
        progressModel = CountProgressModel(task: task, date: .distantFuture)
    }
}
