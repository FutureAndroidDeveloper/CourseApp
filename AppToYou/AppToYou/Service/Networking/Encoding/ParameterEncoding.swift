import Foundation


/**
 Набор кодирования данных запроса.
 */
public enum ParameterEncoding {
    /**
     Кодирование url параметров запроса.
     */
    case urlEncoding

    /**
     Кодирование тела запроса.
     */
    case jsonEncoding

    /**
     Кодирование тела и url параметров запроса.
     */
    case urlAndJsonEncoding

    public func encode<T: Encodable>(urlRequest: inout URLRequest,
                       body: T?,
                       urlParameters: [Parameter]?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)

            case .jsonEncoding:
                guard let body = body else { return }
                try JsonBodyEncoder().encode(urlRequest: &urlRequest, with: body)

            case .urlAndJsonEncoding:
                guard
                    let body = body,
                    let urlParameters = urlParameters
                else {
                    return
                }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JsonBodyEncoder().encode(urlRequest: &urlRequest, with: body)
            }
        } catch {
            throw error
        }
    }

}
