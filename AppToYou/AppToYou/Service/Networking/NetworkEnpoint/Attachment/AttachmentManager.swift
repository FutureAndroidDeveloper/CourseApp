import Foundation
import UIKit


class AttachmentManager: NetworkManager<AttachmentEndpoint> {
    
    func upload(photo: MediaPhoto, completion: @escaping (Result<String, NetworkResponseError>) -> Void) {
        request(.upload(photo: photo), responseType: String.self, decoder: .value, completion)
    }
    
    func download(path: String, completion: @escaping (Result<Data, NetworkResponseError>) -> Void) {
        request(.download(filePath: path), responseType: Data.self, decoder: .value, completion)
    }
    
    func delete(path: String, completion: @escaping (Result<Bool, NetworkResponseError>) -> Void) {
        request(.delete(filePath: path), responseType: Bool.self, decoder: .value, completion)
    }
    
    func loadAvatars(_ users: [UserPublicResponse], completion: @escaping (Result<[UserAvatarInfo], NetworkResponseError>) -> Void) {
        let groupLoad = LoadMembersAvatars(attachmentService: self)
        groupLoad.loadAvatars(users: users, completion: completion)
    }
    
}
