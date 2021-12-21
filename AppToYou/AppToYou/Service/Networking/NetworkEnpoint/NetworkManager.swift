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
    
    
    /**
     Выполнить запрос к серверу.
     
     - parameters:
        - endpoind: endpoind сервера.
        - responseType: ожидаемый тип ответа от сервера.
        - completion: результат обращения к серверу.
     */
    func request<Response: Decodable>(_ endpoind: NetworkEndPoint,
                                      responseType: Response.Type,
                                      _ completion: @escaping (Result<Response, NetworkResponseError>) -> Void) {

        router.request(endpoind) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            let result = self.build(responseType, with: (data, response, error))
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /**
     Создание модели ответа или ошибки
     
     - parameters:
        - response: ожидаемый тип ответа от сервера.
        - routerData: данные полученные после ответа от сервера.
     - returns: Результат работы роутера. `Succsess` - модель ответа сервера.  `Failire` - ошибка.
     */
    private func build<T: Decodable>(_ response: T.Type, with routerData: RouterCompletionData) -> Result<T, NetworkResponseError> {
        if let _ = routerData.error {
            return .failure(.connection)
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
                let apiResponse = try decode(response, from: responseData)
                return .success(apiResponse)
            } catch {
                return .failure(.unableToDecode)
            }
            
        case .failure(let networkFailureError):
            return .failure(networkFailureError)
        }
        
    }

    /**
     Декодинг ответа сервера.
     
     - parameters:
        - type: ожидаемый тип ответа от сервера.
        - data: данные ответа для декодинга.
     
     - returns: Модель ответа сервера.
     */
    private func decode<T: Decodable >(_ type: T.Type, from data: Data) throws -> T {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print(json)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Void, NetworkResponseError> {
        print(response.statusCode)
        switch response.statusCode {
        case 200...299: return .success(())
        case 401...500: return .failure(.authenticationError)
        case 501...599: return .failure(.badRequest)
        case 600: return .failure(.outdated)
        default: return .failure(.failed)
        }
    }
    
}
