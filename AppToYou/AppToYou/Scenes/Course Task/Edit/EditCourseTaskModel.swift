import Foundation


class EditCourseTaskModel: CreateCourseTaskModel {
    var courseNameModel: CourseTaskNameModel?
    
    func addCourseNameModel(name: String) {
        courseNameModel = CourseTaskNameModel(courseName: name)
    }
    
}
