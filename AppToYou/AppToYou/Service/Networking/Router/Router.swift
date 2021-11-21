import Foundation

class Router<EndPoint: Endpoint>: NetworkRouter {
    private var task: URLSessionTask?
    private var body: Encodable?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            
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
        route.headers?
            .compactMap { $0 }
            .forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
    
}
