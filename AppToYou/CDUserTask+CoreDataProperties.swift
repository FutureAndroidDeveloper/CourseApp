//
//  CDUserTask+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUserTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserTask> {
        return NSFetchRequest<CDUserTask>(entityName: "CDUserTask")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var daysCode: String?
    @NSManaged public var editableCourseTask: Bool
    @NSManaged public var frequencyType: String
    @NSManaged public var minimumCourseTaskSanction: Int64
    @NSManaged public var startDate: Date
    @NSManaged public var taskAttribute: String?
    @NSManaged public var taskCompleteTime: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskName: String
    @NSManaged public var taskSanction: Int64
    @NSManaged public var taskType: String
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

    var courseFk: Int64? {
        get {
            self.willAccessValue(forKey: "courseFk")
            let value = self.primitiveValue(forKey: "courseFk") as? Int
            self.didAccessValue(forKey: "courseFk")

            return (value != nil) ? Int64(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "courseFk")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "courseFk")

            self.didChangeValue(forKey: "courseFk")
        }
    }

    var courseTaskId: Int64? {
        get {
            self.willAccessValue(forKey: "courseTaskId")
            let value = self.primitiveValue(forKey: "courseTaskId") as? Int
            self.didAccessValue(forKey: "courseTaskId")

            return (value != nil) ? Int64(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "courseTaskId")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "courseTaskId")

            self.didChangeValue(forKey: "courseTaskId")
        }
    }

    var userFk: Int64? {
        get {
            self.willAccessValue(forKey: "courseTaskId")
            let value = self.primitiveValue(forKey: "courseTaskId") as? Int
            self.didAccessValue(forKey: "courseTaskId")

            return (value != nil) ? Int64(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "courseTaskId")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "courseTaskId")

            self.didChangeValue(forKey: "courseTaskId")
        }
    }

}

extension CDUserTask : Identifiable {

}
