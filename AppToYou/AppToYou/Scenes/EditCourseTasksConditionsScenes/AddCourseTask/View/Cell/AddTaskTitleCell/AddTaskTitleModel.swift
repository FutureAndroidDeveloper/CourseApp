import UIKit


class AddTaskTitleModel {
    let title: String
    let subtitle: String
    let icon: UIImage?
    
    init(title: String, subtitle: String, icon: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
    
}
