import Foundation


class LockButtonModel {
    private(set) var isLocked: Bool
    let stateChanged: (Bool) -> Void
    
    init(isLocked: Bool, stateChanged: @escaping (Bool) -> Void) {
        self.isLocked = isLocked
        self.stateChanged = stateChanged
    }
    
    func update(isLocked: Bool) {
        self.isLocked = isLocked
    }
    
}
