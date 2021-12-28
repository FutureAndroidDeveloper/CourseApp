import Foundation


class CourseConstructorModel {
    var headerModel: CourseHeaderModel?
    var descriptionModel: CourseDescriptionModel?
    var requestsModel: CourseAdminMembersModel?
    var chatModel: JoinCourseChatModel?
    var tasksHeaderModel: CourseTasksModel?
    var tasksModel: [TaskCellModel]
    var createTaskModel: CreateCourseTaskCellModel?
    var membersModel: CourseMembersModel?
    var shareModel: ShareCourseModel?
    var reportModel: ReportCourseModel?
    
    init() {
        tasksModel = []
    }
    
    
    func getConfiguredModels() -> [AnyObject] {
        var models: [AnyObject?] = [
            headerModel, descriptionModel, requestsModel, chatModel, tasksHeaderModel,
            createTaskModel, membersModel, shareModel, reportModel
        ]
        models.insert(contentsOf: tasksModel, at: 5)
        
        return models.compactMap { $0 }
    }
}
