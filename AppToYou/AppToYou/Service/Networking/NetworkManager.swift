import Foundation


/**
 Данные, получаемые после запроса на сервер.
 */
public typealias RouterCompletionData = (
    data: Data?,
    response: URLResponse?,
    error: Error?
)


/**
 Сервис работы с сетью.
 
 `NetworkEndPoint` - ендпоит сервера, к которому идет обращение.
 */
class NetworkManager<NetworkEndPoint: Endpoint> {
    
    private let router: Router<NetworkEndPoint>
    
    /**
     Создание сетевого менеджера.
     
     - parameters:
        - deviceIdentifierService: сервис идентификации устройства.
     */
    init(deviceIdentifierService: DeviceIdentifiable) {
        router = Router(deviceIdentifierService: deviceIdentifierService)
    }
    
    func cancelTask() {
        router.cancel()
    }
    
    /**
     Выполнить запрос к серверу.
     
     - parameters:
        - endpoind: endpoind сервера.
        - responseType: ожидаемый тип ответа от сервера.
        - decoder: декодер ответа сервера.
        - completion: результат обращения к серверу.
     */
    func request<Response: Decodable>(_ endpoind: NetworkEndPoint,
                                      responseType: Response.Type,
                                      decoder: APIResponseDecoder = .json,
                                      _ completion: @escaping (Result<Response, NetworkResponseError>) -> Void) {

        router.request(endpoind) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            let result = self.build(responseType, decoder: decoder.decoder, with: (data, response, error))
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /**
     Создание модели ответа или ошибки
     
     - parameters:
        - response: ожидаемый тип ответа от сервера.
        - decoder: декодер ответа сервера.
        - routerData: данные полученные после ответа от сервера.
     - returns: Результат работы роутера. `Succsess` - модель ответа сервера.  `Failire` - ошибка.
     */
    private func build<T: Decodable>(_ response: T.Type,
                                     decoder: ResponseDecoder,
                                     with routerData: RouterCompletionData) -> Result<T, NetworkResponseError> {
        
        if let routerError = routerData.error {
            return .failure(.custom(message: routerError.localizedDescription))
        }
        
        guard let routerResponse = routerData.response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
        
        switch handleNetworkResponse(routerResponse) {
        case .success:
            guard let responseData = routerData.data else {
                return .failure(.noData)
            }
            
            do {
                let apiResponse = try decoder.decode(response, from: responseData)
                return .success(apiResponse)
            } catch let decodeError {
                print(decodeError)
                return .failure(.unableToDecode)
            }
            
        case .failure(let networkFailureError):
            return .failure(networkFailureError)
        }
        
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Void, NetworkResponseError> {
        let message: String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
        
        switch response.statusCode {
        case 200...299: return .success(())
        default: return .failure(.custom(message: message))
        }
    }
    
}
