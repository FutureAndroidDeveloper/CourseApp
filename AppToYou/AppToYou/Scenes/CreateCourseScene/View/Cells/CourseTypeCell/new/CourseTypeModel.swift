import Foundation


class CourseTypeModel {
    private(set) var value: ATYCourseType
    let courseTypePicked : ((ATYCourseType) -> Void)
    
    init(value: ATYCourseType, courseTypePicked: @escaping (ATYCourseType) -> Void) {
        self.value = value
        self.courseTypePicked = courseTypePicked
    }
    
    func update(value: ATYCourseType) {
        self.value = value
    }
    
}
