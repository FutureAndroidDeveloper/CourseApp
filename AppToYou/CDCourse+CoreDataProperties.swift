//
//  CDCourse+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDCourse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCourse> {
        return NSFetchRequest<CDCourse>(entityName: "CDCourse")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var chatEnabled: Bool
    @NSManaged public var chatPath: String?
    @NSManaged public var cost: Int64
    @NSManaged public var courseTypeCode: Int64
    @NSManaged public var courseDescription: String?
    @NSManaged public var durationType: String?
    @NSManaged public var isInternal: Bool
    @NSManaged public var isOpen: Bool
    @NSManaged public var likes: Int64
    @NSManaged public var courseName: String?
    @NSManaged public var picPath: String?
    @NSManaged public var privacyEnabled: Bool
    @NSManaged public var publicId: String?
    @NSManaged public var usersAmount: Int64
    @NSManaged public var adminFk: Int64
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

extension CDCourse : Identifiable {

}
