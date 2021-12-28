import Foundation


class CreateCourseTaskCellModel {
    private(set) var createTapped: () -> Void
    
    init(createTapped: @escaping () -> Void) {
        self.createTapped = createTapped
    }
    
}
