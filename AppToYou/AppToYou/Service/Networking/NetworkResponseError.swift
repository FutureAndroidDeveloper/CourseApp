import Foundation


enum NetworkResponseError: Error, CustomStringConvertible {
    case connection
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case invalidResponse
    case canceled
    
    var description: String {
        switch self {
        case .connection: return "R.string.localizable.networkConnection()"
        case .authenticationError: return "R.string.localizable.networkAuthentication()"
        case .badRequest: return "R.string.localizable.badRequest()"
        case .outdated: return "R.string.localizable.outdatedURL()"
        case .failed: return "R.string.localizable.requestFailed()"
        case .noData: return "R.string.localizable.networkNoData()"
        case .unableToDecode: return "R.string.localizable.decodeProblem()"
        case .invalidResponse: return "Invalid Response"
        case .canceled: return "Request canceled"
        }
    }
    
}
