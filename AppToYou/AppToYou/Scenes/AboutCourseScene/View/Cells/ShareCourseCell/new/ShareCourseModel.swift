import Foundation


class ShareCourseModel {
    private(set) var shareTapped: () -> Void
    
    init(shareTapped: @escaping () -> Void) {
        self.shareTapped = shareTapped
    }
    
}
