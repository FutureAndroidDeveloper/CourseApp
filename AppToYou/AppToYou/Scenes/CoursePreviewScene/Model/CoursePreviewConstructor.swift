import UIKit


protocol CoursePreviewConstructorDatasource: AnyObject {
    func getCourseName() -> String
    func getCoursePrice() -> Price?
    func getMembersCount() -> Int
    func getLikeCount() -> Int
    func getDescription() -> String?
}


class CoursePreviewConstructor {
    private struct Constants {
        static let defaultCourseImage = R.image.exampleAboutCourse()
    }
    private let model: CoursePreviewConstructorModel
    private let courseType: ATYCourseType
    
    private var loadedOwnerImage: UIImage?
    private var loadedCourseImage: UIImage?
    
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
            courseImage: loadedCourseImage ?? Constants.defaultCourseImage,
            ownerImage: loadedOwnerImage
        )
    }
    
    private func addDescription(_ dataSource: CoursePreviewConstructorDatasource) {
        model.descriptionModel = CourseDescriptionHeaderModel(
            name: dataSource.getCourseName(), price: dataSource.getCoursePrice(),
            members: dataSource.getMembersCount(), likes: dataSource.getLikeCount(),
            courseDescription: dataSource.getDescription()
        )
    }
    
    func handleTasksResponse(_ tasks: [CourseTaskResponse]) {
        model.hintModel?.stopLoading?()
        
        if tasks.isEmpty {
            model.hintModel?.setHint?("На курсе пока нет задач")
        } else {
            let models = tasks.compactMap { task -> CoursePreviewTaskModel? in
                var model: CoursePreviewTaskModel?
                
                if task.taskType == .RITUAL {
                    model = CoursePreviewTaskModelCounter(courseTaskResponse: task)
                } else {
                    model = CoursePreviewTaskModel(courseTaskResponse: task)
                }
                return model
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
        loadedOwnerImage = image
    }
    
    func setCourseImage(_ image: UIImage?) {
        loadedCourseImage = image
    }
}
