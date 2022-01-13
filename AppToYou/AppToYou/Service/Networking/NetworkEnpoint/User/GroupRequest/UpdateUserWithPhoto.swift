import Foundation



class UpdateUserWithPhoto {
    private let group = DispatchGroup()
    private let userService: UserManager
    private let attachmentService: AttachmentManager
    
    init(userService: UserManager, attachmentService: AttachmentManager) {
        self.userService = userService
        self.attachmentService = attachmentService
    }
    
    func update(_ user: UserUpdateRequest, photo: MediaPhoto?, completion: @escaping (Result<UserResponse, NetworkResponseError>) -> Void) {
        
        var userResult: Result<UserResponse, NetworkResponseError> = .failure(.noData)
        var photoResult: Result<String, NetworkResponseError> = .failure(.noData)
        
        group.enter()
        userService.update(user) { result in
            userResult = result
            self.group.leave()
        }
        
        if let photo = photo {
            group.enter()
            attachmentService.upload(photo: photo) { result in
                photoResult = result
                self.group.leave()
            }
        } else {
            photoResult = .success(String())
        }
        
        group.notify(queue: DispatchQueue.main) {
            let result = photoResult.flatMap { _ in
                return userResult
            }
            completion(result)
        }
    }
    
}
