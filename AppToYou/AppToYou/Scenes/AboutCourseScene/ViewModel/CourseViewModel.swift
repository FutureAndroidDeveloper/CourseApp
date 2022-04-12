import Foundation


protocol CourseViewModelInput: AnyObject {
    func editCourseTask(_ task: CourseTaskResponse)
    func refresh()
    func deleteTask()
    func addAllTasks()
    func resetContainerAppearance()
}

protocol CourseViewModelOutput: AnyObject {
    var sections: Observable<[TableViewSection]> { get }
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
