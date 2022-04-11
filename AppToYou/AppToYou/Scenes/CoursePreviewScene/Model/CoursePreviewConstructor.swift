import UIKit


protocol CoursePreviewConstructorDatasource: AnyObject {
    func getCourseName() -> String
    func getCoursePrice() -> Price?
    func getMembersCount() -> Int
    func getLikeCount() -> Int
    func getDescription() -> String?
}


class CoursePreviewConstructor {
    private let model: CoursePreviewConstructorModel
    private let courseType: ATYCourseType
    
    weak var dataSourse: CoursePreviewConstructorDatasource?
    
    init(courseType: ATYCourseType) {
        self.courseType = courseType
        model = CoursePreviewConstructorModel()
    }
    
    func getModels() -> [AnyObject] {
        guard let dataSourse = dataSourse else {
            return []
        }
        
        if courseType != .PRIVATE {
            addLoading()
        }
        addCourseHeader(dataSourse)
        addDescription(dataSourse)
        
        return model.getConfiguredModels()
    }
    
    private func addLoading() {
        model.hintModel = CourseLoadingTasksModel()
    }
    
    private func addCourseHeader(_ dataSource: CoursePreviewConstructorDatasource) {
        model.headerModel = CourseImageHeaderModel(
            courseImage: R.image.exampleAboutCourse(),
            ownerImage: R.image.splash()
        )
    }
    
    private func addDescription(_ dataSource: CoursePreviewConstructorDatasource) {
        model.descriptionModel = CourseDescriptionHeaderModel(
            name: dataSource.getCourseName(), price: dataSource.getCoursePrice(),
            members: dataSource.getMembersCount(), likes: dataSource.getLikeCount(),
            courseDescription: dataSource.getDescription()
        )
    }
    
    func handleTasksResponse(_ tasks: [Task]) {
        model.hintModel?.stopLoading?()
        
        if tasks.isEmpty {
            model.hintModel?.setHint?("На курсе пока нет задач")
        } else {
            let models = tasks.map { task -> CoursePreviewTaskModel in
                var progressModel: TaskProgressModel
                var taskModel: CoursePreviewTaskModel
                let icon = task.taskSanction == 0 ? nil : R.image.coinImage()
                
                if task.taskType == .RITUAL {
                    progressModel = CountProgressModel(task: task, date: .distantFuture)
                    taskModel = CoursePreviewTaskModelCounter(progress: progressModel, title: task.taskName, currencyIcon: icon)
                } else {
                    progressModel = IconProgressModel(task: task, date: .distantFuture)
                    taskModel = CoursePreviewTaskModel(progress: progressModel, title: task.taskName, currencyIcon: icon)
                }
                return taskModel
            }
            model.tasksModel = models
            model.hintModel = nil
        }
    }
    
    func tasksLoadingError() {
        model.hintModel?.stopLoading?()
        model.hintModel?.setHint?("Не удалось загузить задачи курса")
    }
    
    func setOwnerImage(_ image: UIImage?) {
        model.headerModel.ownerImage = image
    }
    
    func setCourseImage(_ image: UIImage?) {
        model.headerModel.courseImage = image
    }
}
