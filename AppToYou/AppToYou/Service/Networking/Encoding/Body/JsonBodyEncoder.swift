import Foundation

/**
 Кодировщик JSON тела запроса.
 */
public struct JsonBodyEncoder: BodyEncoding {

    public func encode<T: Encodable>(urlRequest: inout URLRequest, with body: T) throws {
        do {
            let jsonData = try JSONEncoder().encode(body)
            urlRequest.httpBody = jsonData
        } catch {
            throw RequestEncodingError.bodyEncodingFailed
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }

}
