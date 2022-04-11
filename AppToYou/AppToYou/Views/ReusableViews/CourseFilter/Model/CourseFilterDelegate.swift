import Foundation


protocol CourseFilterDelegate: AnyObject {
    // Все курсы
    // Категории курса
    func categorySelected(_ category: ATYCourseCategory)
    func categoryDeselected(_ category: ATYCourseCategory)
    
    // Курсы пользователя
    func allUserCoursesSelected()
    func adminCoursesSelected()
    func membershipCoursesSelected()
    func requestCoursesSelected()
    
    func coursesFilterDidActive()
    func membershipFilterDidActive()
}
