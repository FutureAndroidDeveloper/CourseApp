import Foundation


class UserSession {
    private struct Constant {
        static let authorizationHeaderKey = "Authorization"
        static let authType = "Basic"
    }
    
    static let shared = UserSession()
    
    private var encodedData: Data
    
    var isActive: Bool {
        return !encodedData.isEmpty
    }
    
    
    private init() {
        encodedData = Data()
    }
    
    func getEncodedData() -> Data {
        return encodedData
    }
    
    func updateEncodedData(_ data: Data) {
        encodedData = data
    }
    
    func getAuthorizationHeader() -> HTTPHeaders {
        guard isActive else {
            return [:]
        }
        return [Constant.authorizationHeaderKey: "\(Constant.authType) \(encodedData.base64EncodedString())"]
    }
    
}
