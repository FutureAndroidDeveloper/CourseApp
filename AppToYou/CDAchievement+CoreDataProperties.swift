//
//  CDAchievement+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
//

import Foundation
import CoreData


extension CDAchievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAchievement> {
        return NSFetchRequest<CDAchievement>(entityName: "CDAchievement")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var type: String?
    @NSManaged public var attribute: Int64
    @NSManaged public var bonus: Int64
    @NSManaged public var descriptionName: String?
    @NSManaged public var name: String?
    @NSManaged public var range: Int64
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

extension CDAchievement : Identifiable {

}
