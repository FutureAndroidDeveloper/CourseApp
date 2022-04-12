import Foundation


struct CourseUserResponse: Codable {
    let courseId: Int?
    let createdTimestamp: String?
    let updatedTimestamp: String?
    let completedTasksAmount: Int?
    let currentSeries: Int?
    let finished: Bool?
    let invitationFrom: UserPublicResponse?
    let likeIt: Bool?
    let maxSeries: Int?
    let personalRating: Int?
    let privateForUser: Bool?
    let sanctionsAmount: Int?
    let user: UserPublicResponse?
    let userStatus: CourseUserStatus?
}
