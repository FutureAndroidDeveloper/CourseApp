import Foundation


protocol SynchronizationDelegate: AnyObject {
    func synchronizationDidStart()
    func synchronizationDidFinish(result: Result<Double, Error>)
}
