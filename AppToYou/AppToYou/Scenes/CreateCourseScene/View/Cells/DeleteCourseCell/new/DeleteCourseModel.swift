import Foundation


class DeleteCourseModel {
    let deleteHandler: (() -> Void)
    
    init(deleteHandler: @escaping () -> Void) {
        self.deleteHandler = deleteHandler
    }
    
}
