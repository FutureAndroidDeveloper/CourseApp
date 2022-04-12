import Foundation


class UpdateCourseWithPhoto {
    private let group = DispatchGroup()
    private let courseService: CourseManager
    private let attachmentService: AttachmentManager
    
    init(courseService: CourseManager, attachmentService: AttachmentManager) {
        self.courseService = courseService
        self.attachmentService = attachmentService
    }
    
    func updateCourse(_ course: CourseUpdateRequest, photo: MediaPhoto?, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        
        var courseResult: Result<CourseResponse, NetworkResponseError> = .failure(.noData)
        var photoResult: Result<String, NetworkResponseError> = .failure(.noData)
        
        group.enter()
        courseService.update(course: course) { result in
            courseResult = result
            self.group.leave()
        }
        
        if let photo = photo {
            group.enter()
            attachmentService.upload(photo: photo) { result in
                photoResult = result
                self.group.leave()
            }
        } else {
            photoResult = .success(String())
        }
        
        group.notify(queue: DispatchQueue.main) {
            let result = photoResult.flatMap { _ in
                return courseResult
            }
            completion(result)
        }
    }
    
}
