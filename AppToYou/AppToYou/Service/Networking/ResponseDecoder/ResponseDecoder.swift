import Foundation


class ResponseDecoder {
    
    /**
     Декодинг ответа сервера.
     
     - parameters:
        - type: ожидаемый тип ответа от сервера.
        - data: данные ответа для декодинга.
     
     - returns: Модель ответа сервера.
     */
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        fatalError()
    }
}


enum APIResponseDecoder {
    case json
    case value
    
    var decoder: ResponseDecoder {
        switch self {
        case .json:
            return JsonResponseDecoder()
        case .value:
            return ValueResponseDecoder()
        }
    }
}
