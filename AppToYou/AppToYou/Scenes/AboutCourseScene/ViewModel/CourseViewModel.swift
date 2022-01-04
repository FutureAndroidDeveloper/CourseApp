import Foundation


protocol CourseViewModelInput: AnyObject {
    func editCourseTask(index: Int)
}

protocol CourseViewModelOutput: AnyObject {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CourseViewModel: AnyObject {
    var input: CourseViewModelInput { get }
    var output: CourseViewModelOutput { get }
}

extension CourseViewModel where Self: CourseViewModelInput & CourseViewModelOutput {
    var input: CourseViewModelInput { return self }
    var output: CourseViewModelOutput { return self }
}
