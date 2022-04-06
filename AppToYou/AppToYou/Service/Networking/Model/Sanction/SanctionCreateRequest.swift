import Foundation


class SanctionCreateRequest: Encodable {
    let sanctionDate: String
    let taskSanction: Int
    let userTaskId: Int
    let phoneId: Int?
    let phoneTaskId: Int?
    
    init(sanctionDate: String, taskSanction: Int, userTaskId: Int, phoneId: Int? = nil, phoneTaskId: Int? = nil) {
        self.sanctionDate = sanctionDate
        self.taskSanction = taskSanction
        self.userTaskId = userTaskId
        self.phoneId = phoneId
        self.phoneTaskId = phoneTaskId
    }
    
}
