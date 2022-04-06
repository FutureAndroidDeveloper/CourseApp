import Foundation


class UpdateInfoResponse: Codable {
    let userTaskResponseList: [UserTaskResponse]?
    
    init(userTaskResponseList: [UserTaskResponse]? = nil) {
        self.userTaskResponseList = userTaskResponseList
    }
}
