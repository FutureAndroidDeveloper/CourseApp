import Foundation


class CourseLoadingTasksModel {
    var stopLoading: (() -> Void)?
    var setHint: ((String) -> Void)?
}
