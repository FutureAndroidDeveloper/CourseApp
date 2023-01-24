import Foundation


enum UserEndpoint: Endpoint {
    
    case create(_ user: UserCreateRequest)
    case update(_ user: UserUpdateRequest)
    case delete
    case updateInfo(_ info: UpdateInfoRequest)
    
    private static let basePath = "https://..."
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        var userPath = "user"
        
        switch self {
        case .create, .update, .delete:
            break
        case .updateInfo:
            userPath.append("/updateInfo")
        }
        return userPath
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .update: return .put
        case .delete: return .delete
        case .updateInfo: return .put
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let user):
            return RequestWithParameters(body: user)
            
        case .update(let user):
            return RequestWithParameters(body: user)
            
        case .delete:
            return Request()
            
        case .updateInfo(let info):
            return RequestWithParameters(body: info)
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .update, .delete, .updateInfo:
            return UserSession.shared.getAuthorizationHeader()
        default:
            return [:]
        }
    }
    
}
