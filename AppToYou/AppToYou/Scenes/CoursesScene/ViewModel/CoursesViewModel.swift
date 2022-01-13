import Foundation


protocol CoursesViewModelInput: AnyObject {
    func createDidTapped()
    func openCourse(_ course: CourseResponse)
    func refresh()
    
    func loadMore()
    
    func downloadCourseImages(for model: CourseCellModel)
    func closeCourseImagesDowloading(for model: CourseCellModel)
}


protocol CoursesViewModelOutput: AnyObject {
    var isLoading: Bool { get }
    var courses: Observable<[CourseResponse]> { get set }
    
    var coursesBatch: Observable<[CourseResponse]> { get set }
    
    var updatedState: Observable<Void> { get }
}


protocol CoursesViewModel: AnyObject {
    var input: CoursesViewModelInput { get }
    var output: CoursesViewModelOutput { get }
}

extension CoursesViewModel where Self: CoursesViewModelInput & CoursesViewModelOutput {
    var input: CoursesViewModelInput { return self }
    var output: CoursesViewModelOutput { return self }
}
