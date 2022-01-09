import UIKit


class InfoTitleModel {
    let title: String?
    let icon: UIImage?
    let notificationType: UserInfoNotification
    
    init(title: String?, icon: UIImage?, notificationType: UserInfoNotification) {
        self.title = title
        self.icon = icon
        self.notificationType = notificationType
    }
    
}
