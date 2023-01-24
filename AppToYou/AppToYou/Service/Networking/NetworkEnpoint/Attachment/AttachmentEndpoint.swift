import Foundation


enum AttachmentEndpoint: Endpoint {
    
    case upload(photo: MediaPhoto)
    case download(filePath: String)
    case delete(filePath: String)
    
    private static let basePath = "https://..."
    
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
            var path: String
            if let fileName = filePath.split(separator: "/").last {
                path = String(fileName)
            } else {
                path = filePath
            }
            
            let pathParameter = Parameter(name: "path", value: path)
            return RequestWithParameters(urlParameters: [pathParameter])
        }
    }
    
    var headers: HTTPHeaders {
        return UserSession.shared.getAuthorizationHeader()
    }
    
}
