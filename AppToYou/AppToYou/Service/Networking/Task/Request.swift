import Foundation


/**
 Пустой запрос.
 */
class Request: HTTPTask {
    
    func prepare(for request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
}
