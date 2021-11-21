import Foundation

/**
 Протокол, который описывает endpoint API.
 */
protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
//    var task: HTTPTask { get }
    var task: Task { get }
    var headers: HTTPHeaders? { get }
}
