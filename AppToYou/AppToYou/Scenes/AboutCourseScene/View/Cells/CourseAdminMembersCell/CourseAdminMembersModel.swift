import Foundation


class CourseAdminMembersModel {
    let newNotifications: String?
    private(set) var membersTapped: () -> Void
    
    init(newNotifications: Int, membersTapped: @escaping () -> Void) {
        self.newNotifications = newNotifications == .zero ? nil : "(+\(newNotifications))"
        self.membersTapped = membersTapped
    }
}
