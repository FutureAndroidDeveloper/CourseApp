import Foundation


class CourseMembersModel {
    let model: CourseMembersViewModel
    private(set) var membersTapped: () -> Void
    
    init(model: CourseMembersViewModel, membersTapped: @escaping () -> Void) {
        self.model = model
        self.membersTapped = membersTapped
    }
    
}
