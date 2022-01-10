import Foundation


enum AttachmentEndpoint: Endpoint {
    
    case upload(photo: MediaPhoto)
    case download(filePath: String)
    case delete(filePath: String)
    
    private static let basePath = "https://apptoyou.qittiq.by:6699/"
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        return "attachment"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .upload: return .post
        case .download: return .get
        case .delete: return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .upload(let photo):
            return PhotoMediaRequest(mediaPhoto: photo)
            
        case .download(let filePath):
            fallthrough
            
        case .delete(let filePath):
            let pathParameter = Parameter(name: "path", value: filePath)
            return RequestWithParameters(urlParameters: [pathParameter])
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
