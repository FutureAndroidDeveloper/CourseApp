import Foundation


struct UserCreateRequest: Encodable {
    let avatarPath: String?
    let loginEmailAddress: String
    let name: String
    let password: String
}
