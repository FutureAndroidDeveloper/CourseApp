import Foundation


class UserManager: NetworkManager<UserEndpoint> {
    
    func create(user: UserCreateRequest, completion: @escaping (Result<UserResponse, NetworkResponseError>) -> Void) {
        request(.create(user), responseType: UserResponse.self, completion)
    }
    
    func update(_ user: UserUpdateRequest, completion: @escaping (Result<UserResponse, NetworkResponseError>) -> Void) {
        request(.update(user), responseType: UserResponse.self, completion)
    }
    
    func delete(completion: @escaping (Result<Bool, NetworkResponseError>) -> Void) {
        request(.delete, responseType: Bool.self, decoder: .value, completion)
    }
    
    func updateUser(_ user: UserUpdateRequest, photo: MediaPhoto?, completion: @escaping (Result<UserResponse, NetworkResponseError>) -> Void) {
        let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())
        let updateUserWithPhoto = UpdateUserWithPhoto(userService: self, attachmentService: attachmentService)
        updateUserWithPhoto.update(user, photo: photo, completion: completion)
    }
    
    func updateInfo(_ info: UpdateInfoRequest, completion: @escaping (Result<UpdateInfoResponse, NetworkResponseError>) -> Void) {
        request(.updateInfo(info), responseType: UpdateInfoResponse.self, completion)
    }
    
}
