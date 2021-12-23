import Foundation


class CourseTypeModel {
    let value: ATYCourseType
    let courseTypePicked : ((ATYCourseType) -> Void)
    
    init(value: ATYCourseType, courseTypePicked: @escaping (ATYCourseType) -> Void) {
        self.value = value
        self.courseTypePicked = courseTypePicked
    }
    
}
