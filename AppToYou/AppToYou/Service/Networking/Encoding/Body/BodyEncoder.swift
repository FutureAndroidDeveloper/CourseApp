import Foundation


/**
 Протокол кодирования тела запроса.
 */
public protocol BodyEncoding {

    /**
     Закодировать тело.

     - parameters:
        - urlRequest: запрос, для которого устанавливается тело.
        - body: тело для запроса.
     */
    func encode<T: Encodable>(urlRequest: inout URLRequest, with body: T) throws

}
