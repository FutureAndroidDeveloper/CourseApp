import Foundation


class CourseConstructorModel {
    var headerModel: CourseHeaderModel?
    var descriptionModel: CourseDescriptionModel?
    var requestsModel: CourseAdminMembersModel?
    var chatModel: JoinCourseChatModel?
    var tasksHeaderModel: CourseTasksModel?
    var hintModel: CourseLoadingTasksModel?
    var tasksModel: [CourseTaskCellModel]
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
            hintModel, createTaskModel, membersModel, shareModel, reportModel
        ]
        models.insert(contentsOf: tasksModel, at: 6)
        
        return models.compactMap { $0 }
    }
}
