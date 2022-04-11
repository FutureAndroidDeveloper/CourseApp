import UIKit


class CoursePreviewTaskModel {
    let progress: TaskProgressModel
    let title: String
    let currencyIcon: UIImage?
    
    init(progress: TaskProgressModel, title: String, currencyIcon: UIImage?) {
        self.progress = progress
        self.title = title
        self.currencyIcon = currencyIcon
    }
}
