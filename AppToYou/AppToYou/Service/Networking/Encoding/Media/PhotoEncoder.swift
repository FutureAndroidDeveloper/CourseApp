import Foundation


public struct PhotoEncoder {
    private let boundary: String
    private let media: MediaPhoto
    
    init(media: MediaPhoto) {
        self.media = media
        self.boundary = "Boundary-\(UUID().uuidString)"
    }

    func encode(urlRequest: inout URLRequest) throws {
        let fullData = try photoDataToFormData(data: media.data)
        urlRequest.setValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(String(fullData.length), forHTTPHeaderField: "Content-Length")
        urlRequest.httpBody = Data(referencing: fullData)
    }
    
    private func photoDataToFormData(data: Data) throws -> NSData {
        let fullData = NSMutableData()
        
        let firstData = try getData(for: "--" + boundary + "\r\n")
        fullData.append(firstData)
        
        let dispositionData = try getData(for: "Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.fileName)\"\r\n")
        fullData.append(dispositionData)
        
        let contentTypeData = try getData(for: "Content-Type: \(media.mimeType.rawValue)\r\n\r\n")
        fullData.append(contentTypeData)
        
        fullData.append(data)
        
        let lineBreakData = try getData(for: "\r\n")
        fullData.append(lineBreakData)
        
        let endData = try getData(for: "--" + boundary + "--\r\n")
        fullData.append(endData)
        
        return fullData
    }
    
    private func getData(for string: String) throws -> Data {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
            throw RequestEncodingError.invalidImage
        }
        return data
    }
    
}
