import Foundation
import UIKit


class JoinCourseChatModel {
    let messanger: String
    let icon: UIImage?
    private(set) var joinTapped: () -> Void
    
    convenience init(joinTapped: @escaping () -> Void) {
        self.init(messanger: "Telegram", icon: R.image.telegram(), joinTapped: joinTapped)
    }
    
    init(messanger: String, icon: UIImage?, joinTapped: @escaping () -> Void) {
        self.messanger = messanger
        self.icon = icon
        self.joinTapped = joinTapped
    }
}
