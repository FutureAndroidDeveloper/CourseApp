import Foundation

enum UserEndpoint: Endpoint {
    
    case create(_ user: UserCreateRequest)
    case update(_ user: UserUpdateRequest)
    case delete
    
    private static let basePath = "https://apptoyou.qittiq.by:6699/"
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        return "user"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .update: return .put
        case .delete: return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let user):
            return RequestWithParameters(body: user, encoding: .jsonEncoding, urlParameters: nil)
            
        case .update(let user):
            return RequestWithParameters(body: user, encoding: .jsonEncoding, urlParameters: nil)
            
        case .delete:
            return Request()
        }
    }
    
    var headers: HTTPHeaders? {
        return ["uuid": "DE6B2DED-8275-4E80-B089-86AD0865F4C7"]
    }
    
}
