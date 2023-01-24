//
//  CDCourseUser+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDCourseUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCourseUser> {
        return NSFetchRequest<CDCourseUser>(entityName: "CDCourseUser")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var completedTasksAmount: Int64
    @NSManaged public var currentSeries: Int64
    @NSManaged public var isFinished: Bool
    @NSManaged public var isPrivateForUser: Bool
    @NSManaged public var likeIt: Bool
    @NSManaged public var maxSeries: Int64
    @NSManaged public var personalRaiting: Int64
    @NSManaged public var sanctionsAmount: Int64
    @NSManaged public var userStatusCode: Int64
    @NSManaged public var courseFk: Int64
    @NSManaged public var invitationFromFk: Int64
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

extension CDCourseUser : Identifiable {

}
