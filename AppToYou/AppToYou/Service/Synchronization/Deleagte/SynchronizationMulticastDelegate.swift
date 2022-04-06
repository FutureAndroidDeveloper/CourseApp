import Foundation


/**
 Класс для подключения нескольких делегатов одному объекту. Реализует свзть 1-N.
 */
class SynchronizationMulticastDelegate {
    private var delegates: [SynchronizationDelegateWrapper] = []

    func add(_ delegate: SynchronizationDelegate) {
        delegates.append(SynchronizationDelegateWrapper(delegate))
    }
    
    func synchronizationDidStart() {
        delegates
            .compactMap { $0.delegate }
            .forEach { $0.synchronizationDidStart() }
    }
    
    func synchronizationDidFinish(result: Result<Double, Error>) {
        delegates
            .compactMap { $0.delegate }
            .forEach { $0.synchronizationDidFinish(result: result) }
    }
}
