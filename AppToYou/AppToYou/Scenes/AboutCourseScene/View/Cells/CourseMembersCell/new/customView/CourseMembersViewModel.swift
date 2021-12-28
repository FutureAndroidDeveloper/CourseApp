import UIKit


class CourseMember {
    let avatar: UIImage?
    
    init(avatar: UIImage?) {
        self.avatar = avatar
    }
}


class CourseMembersViewModel {
    let members: [CourseMember]
    let amountMembers: Int
    
    convenience init() {
        self.init(members: [], amountMembers: 0)
    }
    
    init(members: [CourseMember], amountMembers: Int) {
        self.members = members
        self.amountMembers = amountMembers
    }
    
}
