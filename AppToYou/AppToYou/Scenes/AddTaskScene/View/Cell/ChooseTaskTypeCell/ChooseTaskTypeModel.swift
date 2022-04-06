import UIKit


class ChooseTaskTypeModel {
    let icon: UIImage?
    let title: String?
    let description: String?
    let taskType: TaskType
    
    init(icon: UIImage?, title: String?, description: String?, taskType: TaskType) {
        self.icon = icon
        self.title = title
        self.description = description
        self.taskType = taskType
    }
    
}
