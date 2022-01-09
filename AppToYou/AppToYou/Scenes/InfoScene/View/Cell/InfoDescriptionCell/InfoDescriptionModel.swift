import Foundation


class InfoDescriptionModel {
    let text: String?
    let notificationType: UserInfoNotification
    
    init(text: String?, notificationType: UserInfoNotification) {
        self.text = text
        self.notificationType = notificationType
    }
    
}
