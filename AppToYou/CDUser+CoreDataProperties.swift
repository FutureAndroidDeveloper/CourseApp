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
    @NSManaged public var id: Int64

}

extension CDUser : Identifiable {

}
