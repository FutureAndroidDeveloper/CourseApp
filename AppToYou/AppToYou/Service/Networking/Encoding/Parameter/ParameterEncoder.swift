import Foundation


/**
 Протокол кодирования параметров запроса.
 */
public protocol ParameterEncoder {
    
    /**
     Закодировать параметры запроса.
     
     - parameters:
        - urlRequest: запрос, для которого устанавливаются параметры.
        - parameters: параметры запроса.
     */
    func encode(urlRequest: inout URLRequest, with parameters: [Parameter]) throws
    
}
