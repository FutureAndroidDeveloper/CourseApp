import Foundation


class CoursePreviewConstructorModel {
    var headerModel: CourseImageHeaderModel!
    var descriptionModel: CourseDescriptionHeaderModel!
    var hintModel: CourseLoadingTasksModel?
    var tasksModel: [CoursePreviewTaskModel]
    
    init() {
        tasksModel = []
    }
    
    func getConfiguredModels() -> [AnyObject] {
        var models: [AnyObject?] = [headerModel, descriptionModel, hintModel]
        models.append(contentsOf: tasksModel)
        
        return models.compactMap { $0 }
    }
}
