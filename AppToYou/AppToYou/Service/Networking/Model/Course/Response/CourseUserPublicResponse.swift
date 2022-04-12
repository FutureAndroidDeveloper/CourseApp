import Foundation



struct CourseUserPublicResponse: Codable {
    let courseId: Int?
    let createdTimestamp: String?
    let updatedTimestamp: String?
    let invitationFrom: UserPublicResponse?
    let userPublicResponse: UserPublicResponse?
    let userStatus: CourseUserStatus?
}
