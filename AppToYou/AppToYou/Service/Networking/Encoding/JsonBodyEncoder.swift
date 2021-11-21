//
//  JSONParameterEncoder.swift
//  Currency Converter
//
//  Created by Кирилл Клименков on 3/26/20.
//  Copyright © 2020 Kiryl Klimiankou. All rights reserved.
//

import Foundation

public struct JsonBodyEncoder {
    public func encode<T: Encodable>(urlRequest: inout URLRequest, with body: T) throws {
        do {
            let jsonData = try JSONEncoder().encode(body)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}
