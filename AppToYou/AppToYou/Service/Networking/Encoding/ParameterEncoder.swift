//
//  ParameterEncoder.swift
//  AppToYou
//
//  Created by mac on 21.11.21.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
