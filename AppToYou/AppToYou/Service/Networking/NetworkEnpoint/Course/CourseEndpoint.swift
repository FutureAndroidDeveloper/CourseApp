import Foundation


enum CourseEndpoint: Endpoint {
    
    case create(course: CourseCreateRequest)
    case update(course: CourseUpdateRequest)
    case createTask(courseId: Int, task: CourseTaskCreateRequest)
    case addAllCourseTasks(courseId: Int)
    case addCourseTask(_ model: AddConfiguredCourseTaskModel)
    case getCourse(id: Int)
    case getRequests(courseId: Int)
    case getTasks(courseId: Int)
    case remove(taskId: Int)
    
    case members(pageModel: MembersPageModel)
    
    /**
     Курсы пользователя по его статусу в курсе.
     */
    case memebershipCourses(status: CourseUserStatus)
    
    /**
     Курсы, в которых пользоваетль является администратором.
     */
    case admin(id: Int)
    case search(model: SearchCourseModel)
    
    private static let basePath = "https://..."
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        var result = "course"
        
        switch self {
        case .create, .update:
            break
        case .getCourse(let id):
            result.append("/id\(id)")
        case .createTask(let courseId, _):
            result.append("/id\(courseId)/task")
            
        case .addAllCourseTasks(let courseId):
            result.append("/id\(courseId)/addAll")
        case .addCourseTask(let model):
            result.append("/id\(model.courseId)/add")
        case .getRequests(let courseId):
            result.append("/id\(courseId)/requests")
        case .getTasks(let courseId):
            result.append("/id\(courseId)/taskList")
        case .remove(let taskId):
            result.append("/task/id\(taskId)")
            
        case .memebershipCourses:
            result.append("/list")
        case .admin:
            result.append("/list/admin")
        case .search:
            result.append("/search")
        case .members(let pageModel):
            result.append("/id\(pageModel.courseId)/members")
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .create: return .post
        case .update: return .put
        case .createTask: return .post
        case .remove: return .delete
        case .addAllCourseTasks: return .get
        case .addCourseTask: return .get
        case .getCourse: return .get
        case .getRequests: return .get
        case .getTasks: return .get
            
        case .memebershipCourses: return .get
        case .admin: return .get
        case .search: return .get
        case .members: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .create(let course):
            return RequestWithParameters(body: course)
        case .update(let course):
            return RequestWithParameters(body: course)
        case .createTask(_, let task):
            return RequestWithParameters(body: task)
            
        case .addAllCourseTasks:
            return Request()
        case .addCourseTask(let model):
            return RequestWithParameters(urlParameters: model.getParameters())
        case .getCourse:
            return Request()
        case .getRequests:
            return Request()
        case .getTasks:
            return Request()
        case .remove:
            return Request()
            
        case .memebershipCourses(let status):
            let statusParameter = Parameter(name: "courseUserStatus", value: status)
            return RequestWithParameters(urlParameters: [statusParameter])
        case .admin(let id):
            let idParameter = Parameter(name: "id", value: id)
            return RequestWithParameters(urlParameters: [idParameter])
        case .search(let model):
            let parameters = model.parameters
            return RequestWithParameters(urlParameters: parameters)
        case .members(let pageModel):
            let pageParameter = Parameter(name: "page", value: pageModel.page)
            let sizeParameter = Parameter(name: "pageSize", value: pageModel.pageSize)
            return RequestWithParameters(urlParameters: [pageParameter, sizeParameter])
        }
    }
    
    var headers: HTTPHeaders {
        // TODO: - убрать хедер авторизации для запросов без его использования (search)
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
