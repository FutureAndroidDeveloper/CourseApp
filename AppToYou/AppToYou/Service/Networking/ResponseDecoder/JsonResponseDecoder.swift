import Foundation


class JsonResponseDecoder: ResponseDecoder {
    override func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        print("\nResponse:")
        debugPrint(data.prettyPrintedJSONString ?? String())
        return try JSONDecoder().decode(T.self, from: data)
    }
}
