import Foundation


class CourseTasksModel {
    let addedCount: Int
    let amont: Int
    private(set) var addAllTapped: () -> Void
    
    init(addedCount: Int, amont: Int, addAllTapped: @escaping () -> Void) {
        self.addedCount = addedCount
        self.amont = amont
        self.addAllTapped = addAllTapped
    }
}
