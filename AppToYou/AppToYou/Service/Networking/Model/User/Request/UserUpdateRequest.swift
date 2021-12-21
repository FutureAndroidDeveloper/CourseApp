import Foundation


struct UserUpdateRequest: Encodable {
    let avatarPath: String?
    let name: String
}
