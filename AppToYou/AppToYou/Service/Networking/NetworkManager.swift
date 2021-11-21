import Foundation

public typealias RouterCompletionData = (
    data: Data?,
    response: URLResponse?,
    error: Error?
)

struct NetworkManager {
    
    let userRouter = Router<UserEndpoint>()
    
    func createUser(_ user: UserCreateRequest,
                    completion: @escaping (_ response: UserResponse?, _ error: String?) -> Void) {
        
        userRouter.request(.create(user)) { data, response, error in
            self.build(UserResponse.self,
                       with: (data, response, error),
                       callback: completion)
        }
    }
    
    // MARK: - Private Methods
    private func build<T: Decodable>(_ type: T.Type,
                                    with routerData: RouterCompletionData,
                                    callback completion: @escaping (_ answer: T?, _ error: String?) -> Void) {
        if routerData.error != nil {
            DispatchQueue.main.async {
                completion(nil, "R.string.localizable.networkConnection()")
            }
        }
        
        if let response = routerData.response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = routerData.data else {
                    DispatchQueue.main.async {
                        completion(nil, NetworkResponse.noData.description)
                    }
                    return
                }
                do {
                    let apiResponse = try self.decode(type, from: responseData)
                    DispatchQueue.main.async {
                        completion(apiResponse, nil)
                    }
                } catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil, NetworkResponse.unableToDecode.description)
                    }
                }
                
            case .failure(let networkFailureError):
                DispatchQueue.main.async {
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    private func decode<T: Decodable >(_ type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkingResult<String> {
        print(response.statusCode)
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.description)
        case 501...599: return .failure(NetworkResponse.badRequest.description)
        case 600: return .failure(NetworkResponse.outdated.description)
        default: return .failure(NetworkResponse.failed.description)
        }
    }
}

enum NetworkResponse {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

extension NetworkResponse: CustomStringConvertible {
    var description: String {
        switch self {
        case .authenticationError: return "R.string.localizable.networkAuthentication()"
        case .badRequest: return "R.string.localizable.badRequest()"
        case .outdated: return "R.string.localizable.outdatedURL()"
        case .failed: return "R.string.localizable.requestFailed()"
        case .noData: return "R.string.localizable.networkNoData()"
        case .unableToDecode: return "R.string.localizable.decodeProblem()"
        default: return String()
        }
    }
}

enum NetworkingResult<String>{
    case success
    case failure(String)
}
