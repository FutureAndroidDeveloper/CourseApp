import Foundation


class LockButtonModel {
    private(set) var isLocked: Bool
    
    init(isLocked: Bool) {
        self.isLocked = isLocked
    }
    
    func update(isLocked: Bool) {
        self.isLocked = isLocked
    }
    
}
