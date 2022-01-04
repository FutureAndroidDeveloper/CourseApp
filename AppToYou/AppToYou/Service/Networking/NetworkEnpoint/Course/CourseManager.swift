import Foundation


class CourseManager: NetworkManager<CourseEndpoint> {
    
    func create(course: CourseCreateRequest, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.create(course: course), responseType: CourseResponse.self, completion)
    }
    
    func create(task: CourseTaskCreateRequest, id: Int, completion: @escaping (Result<CourseTaskResponse, NetworkResponseError>) -> Void) {
        request(.createTask(courseId: id, task: task), responseType: CourseTaskResponse.self, completion)
    }
    
    func getCourse(id: Int, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.getCourse(id: id), responseType: CourseResponse.self, completion)
    }
    
    func getTasks(for courseId: Int, completion: @escaping (Result<[CourseTaskResponse], NetworkResponseError>) -> Void) {
        request(.getTasks(courseId: courseId), responseType: [CourseTaskResponse].self, completion)
    }
    
    func remove(taskId: Int, completion: @escaping (Result<Bool, NetworkResponseError>) -> Void) {
        request(.remove(taskId: taskId), responseType: Bool.self, completion)
    }
    
    func adminList(id: Int, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        request(.admin(id: id), responseType: [CourseResponse].self, completion)
    }
    
    func search(model: SearchCourseModel, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        request(.search(model: model), responseType: [CourseResponse].self, completion)
    }
    
    func getFullCourseInfo(id: Int, completion: @escaping (Result<CourseInfoModel, NetworkResponseError>) -> Void) {
        let courseGroupRequest = FullCourseInfo(courseService: self)
        courseGroupRequest.loadCourse(id: id, completion: completion)
    }
    
}
