import Foundation


enum LoginEndpoint: Endpoint {
    
    case login(_ credentials: Credentials)
    case merge(_ credentials: Credentials, update: UpdateInfo)
    case oauth(_ model: OAuthModel)
    
    private static let basePath = "https://apptoyou.qittiq.by:6699/"
    
    var baseURL: URL {
        guard let url = URL(string: Self.basePath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        var result = "user/login"
        
        switch self {
        case .merge(let credentials, _):
            result.append("/merge")
            fallthrough
            
        case .login(let credentials):
            let encodedCredentials = encode(credentials)
            result.append("/\(encodedCredentials)")
            
        case .oauth:
            result.append("/oauth2")
        }
        
        return result
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login: return .get
        case .merge: return .post
        case .oauth: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .login:
            return Request()
            
        case .merge(_, let updateInfo):
            return RequestWithParameters(body: updateInfo)
            
        case .oauth(let model):
            let authParameter = Parameter(name: "authorizationType", value: model.authorization.value)
            
            return RequestWithParameters(urlParameters: [authParameter])
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .oauth(let model):
            return ["token": model.token]
            
        default :
            return [:]
        }
    }
    
    private func encode(_ credentials: Credentials) -> String {
        guard let encodedData = (credentials.mail + ":" + credentials.password).data(using: .utf8) else {
            print("Cant encode creds: \(credentials.mail):\(credentials.password)")
            return String()
        }
        
        UserSession.shared.updateEncodedData(encodedData)
        return encodedData.base64EncodedString()
    }
    
}
