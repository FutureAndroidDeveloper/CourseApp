//
//  CDVacation+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDVacation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVacation> {
        return NSFetchRequest<CDVacation>(entityName: "CDVacation")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
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

extension CDVacation : Identifiable {

}
