import Foundation


class CourseAdminMembersModel {
    let newNotifications: Int
    private(set) var membersTapped: () -> Void
    
    init(newNotifications: Int, membersTapped: @escaping () -> Void) {
        self.newNotifications = newNotifications
        self.membersTapped = membersTapped
    }
}
