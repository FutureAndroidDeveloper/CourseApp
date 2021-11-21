import Foundation

public typealias HTTPHeaders = [String: String]

protocol HTTPTask {
    func prepare(for request: inout URLRequest)
}

class RequestWithParameters<Body: Encodable>: HTTPTask {
    
    private let body: Body
    private let encoding: ParameterEncoding
    
    init(body: Body, encoding: ParameterEncoding, urlParameters: Parameters?) {
        self.body = body
        self.encoding = encoding
    }
    
    
    func prepare(for request: inout URLRequest) {
        try? encoding.encode(urlRequest: &request, body: body, urlParameters: nil)
    }
    
}

class Request: HTTPTask {
    func prepare(for request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
}

class RequestParametersAndHeaders<Body: Encodable>: HTTPTask {
    
    private let body: Body
    private let encoding: ParameterEncoding
    
    init(body: Body, encoding: ParameterEncoding, urlParameters: Parameters?) {
        self.body = body
        self.encoding = encoding
    }
    
    func prepare(for request: inout URLRequest) {
        try? encoding.encode(urlRequest: &request, body: body, urlParameters: nil)
    }
    
}
