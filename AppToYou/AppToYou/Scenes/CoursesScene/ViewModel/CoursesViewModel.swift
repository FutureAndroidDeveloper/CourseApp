import Foundation


protocol CoursesViewModelInput: AnyObject {
    func createDidTapped()
    func openCourse(_ course: CourseResponse)
    func previewCourse(_ course: CourseResponse)
    
    func refresh()
    func loadMore()
    
    func searchTextDidChange(_ text: String)
    func downloadCourseImages(for model: CourseCellModel)
    func closeCourseImagesDowloading(for model: CourseCellModel)
}


protocol CoursesViewModelOutput: AnyObject {
    var models: [CourseCellModel] { get }
    var filterModel: CoursesFilterModel { get }
    
    var isLoading: Observable<Bool> { get set }
    var coursesBatch: Observable<[CourseResponse]> { get set }
    var clearCourses: Observable<Void> { get set }
}


protocol CoursesViewModel: AnyObject {
    var input: CoursesViewModelInput { get }
    var output: CoursesViewModelOutput { get }
}

extension CoursesViewModel where Self: CoursesViewModelInput & CoursesViewModelOutput {
    var input: CoursesViewModelInput { return self }
    var output: CoursesViewModelOutput { return self }
}
