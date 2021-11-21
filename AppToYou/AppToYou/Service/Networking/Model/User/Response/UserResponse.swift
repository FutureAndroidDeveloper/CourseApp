import Foundation

struct UserResponse: Decodable {
    let id: Int64?
    let createdTimestamp: String?
    let updatedTimestamp: String?
    let avatarPath: String?
    let loginEmailAddress: String
    let name: String
}
