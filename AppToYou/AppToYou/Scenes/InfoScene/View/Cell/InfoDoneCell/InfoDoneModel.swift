import Foundation


class InfoDoneModel {
    let title: String?
    let action: () -> Void
    
    init(title: String?, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
}
