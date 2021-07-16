//
//  CDUser+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var uuid: String?
    @NSManaged public var avatarPath: String?
    @NSManaged public var loginEmail: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var authentification: String?
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

extension CDUser : Identifiable {

}
