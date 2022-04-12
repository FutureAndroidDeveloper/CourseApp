import UIKit


class CourseTaskCellModel {
    var progressModel: TaskProgressModel
    let descriptionModel: TaskDescriptionModel
    let isSelected: Bool
    let currencyIcon: UIImage?
    
    var selectionDidChange: ((CourseTaskResponse, Bool) -> Void)?
    
    private(set) var task: Task?
    private (set) var courseTaskResponse: CourseTaskResponse
    private let descriptionProvider = TaskDescriptionProvider()
    private let adapter = TaskAdapter()
    
    
    init?(courseTaskResponse: CourseTaskResponse, isSelected: Bool = false) {
        guard let task = adapter.convert(courseTaskResponse: courseTaskResponse) else {
            return nil
        }
        self.courseTaskResponse = courseTaskResponse
        self.isSelected = isSelected
        self.task = task
        
        progressModel = IconProgressModel(task: task, date: .distantFuture)
        descriptionModel = descriptionProvider.convert(task: task)
        currencyIcon = task.taskSanction == 0 ? nil : R.image.coinImage()
    }
    
    func selectionChanged(_ isSelected: Bool) {
        selectionDidChange?(courseTaskResponse, isSelected)
    }
}
