import UIKit


class CourseMembersViewModel {
    let members: [UserAvatarInfo]
    let amountMembers: Int
    
    convenience init() {
        self.init(members: [], amountMembers: 0)
    }
    
    init(members: [UserAvatarInfo], amountMembers: Int) {
        self.members = members
        self.amountMembers = amountMembers
    }
    
}
