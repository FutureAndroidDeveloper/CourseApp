//
//  CDCourseTask+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDCourseTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCourseTask> {
        return NSFetchRequest<CDCourseTask>(entityName: "CDCourseTask")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var daysCode: String?
    @NSManaged public var editable: Bool
    @NSManaged public var frequencyType: String?
    @NSManaged public var infiniteExecution: Bool
    @NSManaged public var minSanction: Int64
    @NSManaged public var taskAttribute: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskName: String?
    @NSManaged public var taskSanction: Int64
    @NSManaged public var taskType: String?
    @NSManaged public var courseFk: Int64
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

extension CDCourseTask : Identifiable {

}
