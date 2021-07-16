//
//  ATYParser.swift
//  AppToYou
//
//  Created by Philip Bratov on 01.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation

public class ATYParser {

    public func errorLogString(forFieldName fieldName: String, objectName: String) -> String {
        return "Field <\(fieldName)> of object \(objectName) should contain value but it's not"
    }
}
