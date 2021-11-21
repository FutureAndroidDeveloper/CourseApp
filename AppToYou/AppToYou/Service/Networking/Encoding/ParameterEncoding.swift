//
//  ParameterEncoding.swift
//  Currency Converter
//
//  Created by Кирилл Клименков on 3/26/20.
//  Copyright © 2020 Kiryl Klimiankou. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode<T: Encodable>(urlRequest: inout URLRequest,
                       body: T?,
                       urlParameters: Parameters?) throws {
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


public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
