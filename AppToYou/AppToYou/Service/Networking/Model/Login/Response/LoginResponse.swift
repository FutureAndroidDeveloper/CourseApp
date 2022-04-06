import Foundation


struct LoginResponse: Decodable {
    let loginStatus: LoginStsatus
    let updateInfoResponse: UpdateInfoResponse?
    let userResponse: UserResponse?
}
