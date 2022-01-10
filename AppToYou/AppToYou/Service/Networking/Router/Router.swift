import Foundation

class Router<EndPoint: Endpoint>: NetworkRouter {
    
    private var task: URLSessionTask?
    private let deviceIdentifierService: DeviceIdentifiable
    
    
    init(deviceIdentifierService: DeviceIdentifiable) {
        self.deviceIdentifierService = deviceIdentifierService
    }
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            print("\nRequest to:")
            debugPrint(request.url?.absoluteString)
            print(request.cURL(pretty: true))
            
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        route.task.prepare(for: &request)
        request.httpMethod = route.httpMethod.rawValue
        configureHeaders(for: route, request: &request)
        
        return request
    }
    
    
    private func configureHeaders(for route: EndPoint, request: inout URLRequest) {
        request.addValue(deviceIdentifierService.getDeviceUUID(), forHTTPHeaderField: "uuid")
        
        route.headers
            .forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
    }
    
}


extension URLRequest {
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
