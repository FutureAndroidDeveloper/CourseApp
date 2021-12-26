import Foundation


enum CourseEndpoint: Endpoint {
    
    case create(course: CourseCreateRequest)
    
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
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let course):
            return RequestWithParameters(body: course)
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
