import UIKit


public struct MediaPhoto {
    let data: Data
    let fileName: String
    let key: String = "file"
    let mimeType: MimeType = .jpeg

    init(data: Data, fileName: String) {
        self.data = data
        self.fileName = fileName
    }
    
}


public enum MimeType: String {
    case jpeg = "image/jpg"
    case aiff = "audio/aiff"
}
