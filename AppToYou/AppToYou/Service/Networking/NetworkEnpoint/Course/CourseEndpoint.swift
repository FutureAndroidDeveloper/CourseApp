import Foundation


enum CourseEndpoint: Endpoint {
    
    case create(course: CourseCreateRequest)
    case createTask(courseId: Int, task: CourseTaskCreateRequest)
    case getCourse(id: Int)
    case getTasks(courseId: Int)
    case remove(taskId: Int)
    case admin(id: Int)
    case search(model: SearchCourseModel)
    
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
        case .getCourse(let id):
            result.append("/id\(id)")
        case .createTask(let courseId, _):
            result.append("/id\(courseId)/task")
        case .getTasks(let courseId):
            result.append("/id\(courseId)/taskList")
        case .remove(let taskId):
            result.append("/task/id\(taskId)")
        case .admin:
            result.append("/list/admin")
        case .search:
            result.append("/search")
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .createTask: return .post
        case .remove: return .delete
        case .getCourse: return .get
        case .getTasks: return .get
        case .admin: return .get
        case .search: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let course):
            return RequestWithParameters(body: course)
        case .createTask(_, let task):
            return RequestWithParameters(body: task)
        case .getCourse:
            return Request()
        case .getTasks:
            return Request()
        case .remove:
            return Request()
        case .admin(let id):
            let idParameter = Parameter(name: "id", value: id)
            return RequestWithParameters(urlParameters: [idParameter])
        case .search(let model):
            let parameters = model.parameters
            return RequestWithParameters(urlParameters: parameters)
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
