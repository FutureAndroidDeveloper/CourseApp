//
//  CDStore+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStore> {
        return NSFetchRequest<CDStore>(entityName: "CDStore")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var coinsAmount: Int64
    @NSManaged public var id: Int64
    @NSManaged public var currency: String?
    @NSManaged public var price: Int64
    var backId: Int64? {
        get {
            self.willAccessValue(forKey: "backId")
            let value = self.primitiveValue(forKey: "backId") as? Int
            self.didAccessValue(forKey: "backId")

            return (value != nil) ? Int64(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "backId")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "backId")

            self.didChangeValue(forKey: "backId")
        }
    }

}

extension CDStore : Identifiable {

}
