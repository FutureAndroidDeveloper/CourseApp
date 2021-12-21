import Foundation


struct LoginResponse: Decodable {
    let loginStatus: LoginStsatus
    let userResponse: UserResponse?
}
