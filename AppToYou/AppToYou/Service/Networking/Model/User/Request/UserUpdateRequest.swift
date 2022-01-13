import Foundation


struct UserUpdateRequest: Encodable {
    let name: String
    var avatarPath: String?
}
