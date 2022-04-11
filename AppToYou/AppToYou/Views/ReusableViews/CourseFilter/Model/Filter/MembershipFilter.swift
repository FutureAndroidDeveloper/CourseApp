import Foundation


class MembershipFilter: FilterHandler {
    private let membership: CourseMembership
    
    var stateDidChange: ((CourseMembership, Bool) -> Void)?
    var title: String?
    var isSelected: Bool {
        didSet {
            stateDidChange?(membership, isSelected)
        }
    }
    
    init(membership: CourseMembership, isSelected: Bool = false) {
        self.membership = membership
        self.isSelected = isSelected
        self.title = membership.title
    }
}
