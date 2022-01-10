import Foundation


class ValueResponseDecoder: ResponseDecoder {
    override func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        if T.self == String.self {
            let value = String(decoding: data, as: UTF8.self)
            return value as! T
        }
        
        if T.self == Data.self {
            return data as! T
        }
        
        // Bool + Numeric
        let value = data.withUnsafeBytes { pointer in
            return pointer.load(as: type.self)
        }
        
        return value
    }
}
