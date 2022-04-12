import Foundation


class CourseManager: NetworkManager<CourseEndpoint> {
    
    func create(course: CourseCreateRequest, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.create(course: course), responseType: CourseResponse.self, completion)
    }
    
    func update(course: CourseUpdateRequest, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.update(course: course), responseType: CourseResponse.self, completion)
    }
    
    func create(task: CourseTaskCreateRequest, id: Int, completion: @escaping (Result<CourseTaskResponse, NetworkResponseError>) -> Void) {
        request(.createTask(courseId: id, task: task), responseType: CourseTaskResponse.self, completion)
    }
    
    func addAllTasks(courseId: Int, completion: @escaping (Result<[UserTaskResponse], NetworkResponseError>) -> Void) {
        request(.addAllCourseTasks(courseId: courseId), responseType: [UserTaskResponse].self, completion)
    }
    
    func addCourseTask(_ model: AddConfiguredCourseTaskModel, completion: @escaping (Result<UserTaskResponse, NetworkResponseError>) -> Void) {
        request(.addCourseTask(model), responseType: UserTaskResponse.self, completion)
    }
    
    func getCourse(id: Int, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        request(.getCourse(id: id), responseType: CourseResponse.self, completion)
    }
    
    func getRequests(for courseId: Int, completion: @escaping (Result<[CourseUserPublicResponse], NetworkResponseError>) -> Void) {
        request(.getRequests(courseId: courseId), responseType: [CourseUserPublicResponse].self, completion)
    }
    
    func getTasks(for courseId: Int, completion: @escaping (Result<[CourseTaskResponse], NetworkResponseError>) -> Void) {
        request(.getTasks(courseId: courseId), responseType: [CourseTaskResponse].self, completion)
    }
    
    func remove(taskId: Int, completion: @escaping (Result<Bool, NetworkResponseError>) -> Void) {
        request(.remove(taskId: taskId), responseType: Bool.self, completion)
    }
    
    
    func allUserCourses(completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        let allCoursesGroupRequest = AllUserCourses(courseService: self)
        allCoursesGroupRequest.loadCourses(completion: completion)
    }
    
    func listWithStatus(_ status: CourseUserStatus, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        request(.memebershipCourses(status: status), responseType: [CourseResponse].self, completion)
    }
    
    func adminList(id: Int, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        request(.admin(id: id), responseType: [CourseResponse].self, completion)
    }
    
    func search(model: SearchCourseModel, completion: @escaping (Result<[CourseResponse], NetworkResponseError>) -> Void) {
        cancelTask()
        request(.search(model: model), responseType: [CourseResponse].self, completion)
    }
    
    func members(page: MembersPageModel, completion: @escaping (Result<[CourseUserResponse], NetworkResponseError>) -> Void) {
        request(.members(pageModel: page), responseType: [CourseUserResponse].self, completion)
    }
    
    
    func getFullCourseInfo(id: Int, completion: @escaping (Result<CourseInfoModel, NetworkResponseError>) -> Void) {
        let courseGroupRequest = FullCourseInfo(courseService: self)
        courseGroupRequest.loadCourse(id: id, completion: completion)
    }
    
    func createCourse(_ course: CourseCreateRequest, photo: MediaPhoto?, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())
        let createCourseGroupRequest = CreateCourseWithPhoto(courseService: self, attachmentService: attachmentService)
        createCourseGroupRequest.createCourse(course, photo: photo, completion: completion)
    }
    
    func updateCourse(_ course: CourseUpdateRequest, photo: MediaPhoto?, completion: @escaping (Result<CourseResponse, NetworkResponseError>) -> Void) {
        let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())
        let updateCourseGroupRequest = UpdateCourseWithPhoto(courseService: self, attachmentService: attachmentService)
        updateCourseGroupRequest.updateCourse(course, photo: photo, completion: completion)
    }
    
}
