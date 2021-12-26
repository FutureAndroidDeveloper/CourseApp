import Foundation


class CourseManager: NetworkManager<CourseEndpoint> {
    
    func create(course: CourseCreateRequest, completion: @escaping (Result<CourseCreateRequest, NetworkResponseError>) -> Void) {
        request(.create(course: course), responseType: CourseCreateRequest.self, completion)
    }
    
}
