import Foundation


class CourseCounterTaskCell: CourseTaskCell {
    private let countProgressView = CountTaskProgressView()
    
    override var progressView: TaskProgressView {
        return countProgressView
    }
}
