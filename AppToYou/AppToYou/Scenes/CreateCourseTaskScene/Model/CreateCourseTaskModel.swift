import Foundation


class CreateCourseTaskModel: DefaultCreateTaskModel {
    var lockHeaderModel: CourseTaskLockModel?
//    var courseNameModel: CourseTaskNameModel?
    var minSanctionModel: CourseTaskMinSanctionModel?
    
    private var prevcourseTaskDurationModel: CourseTaskDurationModel?
    var courseTaskDurationModel: CourseTaskDurationModel?
    
    func addLockHeaderModel() {
        lockHeaderModel = CourseTaskLockModel()
    }
    
//    func addCourseNameModel(name: String) {
//        courseNameModel = CourseTaskNameModel(courseName: name)
//    }
    
    func addCourseMinSanction(model: NaturalNumberFieldModel) {
        minSanctionModel = CourseTaskMinSanctionModel(fieldModel: model)
    }
    
    func addCourseTaskDurationHandler(duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel, timerCallback: @escaping () -> Void) {
        let model = CourseTaskDurationModel(durationModel: duration, isInfiniteModel: isInfiniteModel, timerCallback: timerCallback)
        prevcourseTaskDurationModel = prevcourseTaskDurationModel ?? model
        courseTaskDurationModel = prevcourseTaskDurationModel
    }
    
    override func prepare() -> [AnyObject] {
//        var result: [AnyObject?] = [lockHeaderModel, courseNameModel, nameModel]
        var result: [AnyObject?] = [lockHeaderModel, nameModel]
        
        let tail: [AnyObject?] = [
            frequencyModel, selectDateModel, weekdayModel, courseTaskDurationModel,
            notificationModel, sanctionModel, minSanctionModel,
        ]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result.compactMap { $0 }
    }
}
