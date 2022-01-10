import Foundation


public enum MediaEncoding {
    
    case photoEncoding(media: MediaPhoto)
    
    public func encode(urlRequest: inout URLRequest) throws {
        do {
            switch self {
            case .photoEncoding(let media):
                try PhotoEncoder(media: media).encode(urlRequest: &urlRequest)
            }
        } catch {
            throw error
        }
    }
    
}
