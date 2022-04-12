import Foundation


class FullCourseInfo {
    private let group = DispatchGroup()
    private let courseService: CourseManager
    
    init(courseService: CourseManager) {
        self.courseService = courseService
    }
    
    func loadCourse(id: Int, completion: @escaping (Result<CourseInfoModel, NetworkResponseError>) -> Void) {
        var courseResult: Result<CourseResponse, NetworkResponseError> = .failure(.noData)
        var tasksResult: Result<[CourseTaskResponse], NetworkResponseError> = .failure(.noData)
        var requestsResult: Result<[CourseUserPublicResponse], NetworkResponseError> = .failure(.noData)
        
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
        
        group.enter()
        if case let .success(course) = courseResult, course.courseType != .PUBLIC {
            self.courseService.getRequests(for: id) { result in
                requestsResult = result
                self.group.leave()
            }
        } else {
            requestsResult = .success([])
            self.group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            switch (courseResult, tasksResult, requestsResult) {
            case (.success(let course), .success(let tasks), .success(let requests)):
                let infoModel = CourseInfoModel(course: course, tasks: tasks, requests: requests)
                completion(.success(infoModel))
            default:
                completion(.failure(.noData))
            }
        }
    }
    
}


//class FullCourseInfo {
//    private struct Constants {
//        static let page = 1
//        static let size = 5
//    }
//    private let group = DispatchGroup()
//    private let courseService: CourseManager
//    private let attachmentService: AttachmentManager
//
//    init(courseService: CourseManager, attachmentService: AttachmentManager) {
//        self.courseService = courseService
//        self.attachmentService = attachmentService
//    }
//
//    func loadCourse(id: Int, completion: @escaping (Result<CourseInfoModel, NetworkResponseError>) -> Void) {
//        var courseResult: Result<CourseResponse, NetworkResponseError> = .failure(.noData)
//        var tasksResult: Result<[CourseTaskResponse], NetworkResponseError> = .failure(.noData)
//        var requestsResult: Result<[CourseUserPublicResponse], NetworkResponseError> = .failure(.noData)
//        var membersResult: Result<[CourseUserResponse], NetworkResponseError> = .failure(.noData)
//        var iconsData = [Data]()
//
//        group.enter()
//        self.courseService.getCourse(id: id) { result in
//            courseResult = result
//            self.group.leave()
//        }
//
//        group.enter()
//        self.courseService.getTasks(for: id) { result in
//            tasksResult = result
//            self.group.leave()
//        }
//
//        group.enter()
//        let page = MembersPageModel(courseId: id, page: Constants.page, pageSize: Constants.size)
//        self.courseService.members(page: page) { result in
//            membersResult = result
//            self.group.leave()
//        }
//
//        group.enter()
//        if case let .success(course) = courseResult, course.courseType != .PUBLIC {
//            self.courseService.getRequests(for: id) { result in
//                requestsResult = result
//                self.group.leave()
//            }
//        } else {
//            requestsResult = .success([])
//            self.group.leave()
//        }
//
//        group.enter()
//        if case let .success(members) = membersResult {
//            for member in members {
//                group.enter()
//                guard let path = member.user?.avatarPath else {
//                    group.leave()
//                    continue
//                }
//                self.attachmentService.download(path: path) { result in
//                    guard let data = try? result.get() else {
//                        self.group.leave()
//                        return
//                    }
//                    iconsData.append(data)
//                    self.group.leave()
//                }
//            }
//            group.leave()
//        } else {
//            self.group.leave()
//        }
//
//        group.notify(queue: DispatchQueue.main) {
//            switch (courseResult, tasksResult, requestsResult) {
//            case (.success(let course), .success(let tasks), .success(let requests)):
//                let infoModel = CourseInfoModel(course: course, tasks: tasks, requests: requests, memberIconsData: iconsData)
//                completion(.success(infoModel))
//            default:
//                completion(.failure(.noData))
//            }
//        }
//    }
//
//}
