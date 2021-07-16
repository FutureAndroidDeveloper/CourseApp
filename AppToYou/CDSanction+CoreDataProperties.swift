//
//  CDSanction+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
//

import Foundation
import CoreData


extension CDSanction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSanction> {
        return NSFetchRequest<CDSanction>(entityName: "CDSanction")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var sanctionDate: Date?
    @NSManaged public var taskSanction: Int64
    @NSManaged public var transactionId: Int64
    @NSManaged public var userId: Int64
    @NSManaged public var wasPayed: Bool
    @NSManaged public var userTaskFk: Int64
    @NSManaged public var id: Int64
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

extension CDSanction : Identifiable {

}
