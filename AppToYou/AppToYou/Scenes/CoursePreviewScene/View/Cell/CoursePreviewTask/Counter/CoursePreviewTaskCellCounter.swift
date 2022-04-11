import Foundation


class CoursePreviewTaskCellCounter: CoursePreviewTaskCell {
    private let countProgressView = CountTaskProgressView()
    
    override var progressView: TaskProgressView {
        return countProgressView
    }
}
