import Foundation


struct CourseInfoModel {
    var course: CourseResponse
    var tasks: [CourseTaskResponse]
}



class FullCourseInfo {
    private let group = DispatchGroup()
    private let courseService: CourseManager
    
    init(courseService: CourseManager) {
        self.courseService = courseService
    }
    
    func loadCourse(id: Int, completion: @escaping (Result<CourseInfoModel, NetworkResponseError>) -> Void) {
        
        var courseResult: Result<CourseResponse, NetworkResponseError> = .failure(.noData)
        var tasksResult: Result<[CourseTaskResponse], NetworkResponseError> = .failure(.noData)
        
        group.enter()
        self.courseService.getCourse(id: id) { result in
            courseResult = result
            self.group.leave()
        }
        
        group.enter()
        self.courseService.getTasks(for: id) { result in
            tasksResult = result
            self.group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            let result = courseResult.flatMap { course -> Result<(CourseResponse, [CourseTaskResponse]), NetworkResponseError> in
                tasksResult.map { tasks in
                    return (course, tasks)
                }
            }.map { CourseInfoModel(course: $0.0, tasks: $0.1) }
            
            completion(result)
        }
    }
    
}
