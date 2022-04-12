import UIKit


class CoursePreviewTaskModel {
    var progressModel: TaskProgressModel
    let title: String
    let currencyIcon: UIImage?
    
    private(set) var task: Task?
    private let adapter = TaskAdapter()
    
    init?(courseTaskResponse: CourseTaskResponse) {
        guard let task = adapter.convert(courseTaskResponse: courseTaskResponse) else {
            return nil
        }
        self.task = task
        
        progressModel = IconProgressModel(task: task, date: .distantFuture)
        title = task.taskName
        currencyIcon = task.taskSanction == 0 ? nil : R.image.coinImage()
    }
}
