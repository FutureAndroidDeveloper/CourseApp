import Foundation


class AllUserCourses {
    private let group = DispatchGroup()
    private let courseService: CourseManager
    
    init(courseService: CourseManager) {
        self.courseService = courseService
    }
    
    func loadCourses(completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        guard let adminId = UserSession.shared.getUser()?.id else {
            completion(.failure(.noData))
            return
        }
        var adminResult: Result<[CourseResponse], NetworkResponseError> = .failure(.noData)
        var memberResult: Result<[CourseResponse], NetworkResponseError> = .failure(.noData)
        var requestResult: Result<[CourseResponse], NetworkResponseError> = .failure(.noData)
        
        group.enter()
        self.courseService.adminList(id: adminId) { result in
            adminResult = result
            self.group.leave()
        }
        
        group.enter()
        self.courseService.listWithStatus(.MEMBER) { result in
            memberResult = result
            self.group.leave()
        }
        
        group.enter()
        self.courseService.listWithStatus(.REQUEST) { result in
            requestResult = result
            self.group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            switch (adminResult, memberResult, requestResult) {
            case (.success(let adminCourses), .success(let memberCourses), .success(let requestCourses)):
                let courses = (adminCourses + memberCourses + requestCourses)
                let crossReference = Dictionary.init(grouping: courses, by: \.id)
                let uniqCourses = crossReference
                    .compactMapValues { $0.first }
                    .compactMap { $1 }
                    .sorted { $0.usersAmount > $1.usersAmount }
                
                completion(.success(uniqCourses))
            default:
                completion(.failure(.noData))
            }
        }
    }
    
}
