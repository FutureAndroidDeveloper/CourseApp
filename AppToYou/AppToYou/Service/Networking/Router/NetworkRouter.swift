import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/**
 Протокол роутера для взаимодействия с Api.
 */
protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: Endpoint
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
