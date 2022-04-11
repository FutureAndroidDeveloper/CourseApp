import Foundation


enum CourseUserStatus: String, Codable {
    case MEMBER, REQUEST, INVITATION, BANNED
}


struct CourseUserStatusBody: Codable {
    let courseUserStatus: CourseUserStatus
    
    init(_ status: CourseUserStatus) {
        courseUserStatus = status
    }
}
