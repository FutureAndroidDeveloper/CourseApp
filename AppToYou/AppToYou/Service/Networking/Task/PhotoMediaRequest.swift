import Foundation


class PhotoMediaRequest: HTTPTask {
    
    private let mediaPhoto: MediaPhoto
    
    init(mediaPhoto: MediaPhoto) {
        self.mediaPhoto = mediaPhoto
    }
    
    func prepare(for request: inout URLRequest) {
        try? MediaEncoding.photoEncoding(media: mediaPhoto).encode(urlRequest: &request)
    }
}
