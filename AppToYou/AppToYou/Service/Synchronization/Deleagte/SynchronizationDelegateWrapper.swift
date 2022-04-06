import Foundation


struct SynchronizationDelegateWrapper {
    weak var delegate: SynchronizationDelegate?

    init(_ delegate: SynchronizationDelegate) {
        self.delegate = delegate
    }
}
