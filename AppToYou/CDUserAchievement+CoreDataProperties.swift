//
//  CDUserAchievement+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUserAchievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserAchievement> {
        return NSFetchRequest<CDUserAchievement>(entityName: "CDUserAchievement")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var completionDate: Date?
    @NSManaged public var achievementFk: Int64
    @NSManaged public var userFk: Int64
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

extension CDUserAchievement : Identifiable {

}
