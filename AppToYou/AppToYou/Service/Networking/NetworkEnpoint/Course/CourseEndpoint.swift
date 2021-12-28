import Foundation


enum CourseEndpoint: Endpoint {
    
    case create(course: CourseCreateRequest)
    case admin(id: Int)
    
    private static let basePath = "https://apptoyou.qittiq.by:6699/"
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        var result = "course"
        
        switch self {
        case .create:
            break
        case .admin:
            result.append("/list/admin")
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .admin: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let course):
            return RequestWithParameters(body: course)
        case .admin(let id):
            let idParameter = Parameter(name: "id", value: id)
            return RequestWithParameters(urlParameters: [idParameter])
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
