import UIKit


struct UserAvatarInfo {
    let avatarIcon: UIImage?
    let name: String
    
    var firstNameLetter: String {
        guard let firstLetter = name.first else {
            return "@"
        }
        return String(firstLetter)
    }
}


class LoadMembersAvatars {
    private let group = DispatchGroup()
    private let attachmentService: AttachmentManager
    
    init(attachmentService: AttachmentManager) {
        self.attachmentService = attachmentService
    }
    
    func loadAvatars(users: [UserPublicResponse], completion: @escaping (Result<[UserAvatarInfo], NetworkResponseError>) -> Void) {
        var userInfo: [UserAvatarInfo] = []
        
        for user in users {
            group.enter()
            
            if let path = user.avatarPath {
                attachmentService.download(path: path) { result in
                    switch result {
                    case .success(let data):
                        let info = UserAvatarInfo(avatarIcon: UIImage(data: data), name: user.name)
                        userInfo.append(info)
                        
                    case .failure:
                        let info = UserAvatarInfo(avatarIcon: nil, name: user.name)
                        userInfo.append(info)
                    }
                    self.group.leave()
                }
            } else {
                let info = UserAvatarInfo(avatarIcon: nil, name: user.name)
                userInfo.append(info)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(.success(userInfo))
        }
    }
    
}
