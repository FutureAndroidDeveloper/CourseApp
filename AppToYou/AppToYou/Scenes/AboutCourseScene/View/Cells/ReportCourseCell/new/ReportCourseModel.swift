import Foundation


class ReportCourseModel {
    private(set) var reportTapped: () -> Void
    
    init(reportTapped: @escaping () -> Void) {
        self.reportTapped = reportTapped
    }
    
}
