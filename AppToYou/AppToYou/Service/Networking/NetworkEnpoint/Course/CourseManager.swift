import Foundation


class CourseManager: NetworkManager<CourseEndpoint> {
    
    func create(course: CourseCreateRequest, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.create(course: course), responseType: CourseResponse.self, completion)
    }
    
    func adminList(id: Int, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        request(.admin(id: id), responseType: [CourseResponse].self, completion)
    }
}
