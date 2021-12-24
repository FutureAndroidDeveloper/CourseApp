import Foundation


enum TaskEndpoint: Endpoint {
    
    case create(task: UserTaskCreateRequest)
    case update(task: UserTaskCreateRequest)
    case remove(id: Int)
    case get(id: Int)
    case setResults(id: Int, result: [String])
    case fullList
    case activeList
    
    private static let basePath = "https://apptoyou.qittiq.by:6699/"
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        var result = "userTask"
        
        switch self {
        case .create: fallthrough
        case .update: break
            
        case .remove(let id): fallthrough
        case .get(let id): fallthrough
        case .setResults(let id, _):
            result.append("")
            result.append("/id\(id)")
            break
            
        case .fullList:
            result.append("/fullList")
        case .activeList:
            result.append("/list")
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .remove: return .delete
            
        case .setResults: fallthrough
        case .update: return .put
            
        case .get: fallthrough
        case .fullList: fallthrough
        case .activeList: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let task):
            return RequestWithParameters(body: task)
        case .update(let task):
            return Request()
        case .remove(let id):
            return Request()
        case .get(let id):
            return Request()
        case .setResults(let id, let result):
            return Request()
        case .fullList:
            return Request()
        case .activeList:
            return Request()
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
