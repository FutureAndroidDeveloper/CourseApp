import Foundation


class InfoPayLaterModel {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
}
