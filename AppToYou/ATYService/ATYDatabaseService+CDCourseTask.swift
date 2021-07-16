//
//  ATYDatabaseService+CDCourseTask.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getCourseTask(id: Int) -> CDCourseTask? {
        return self.fetchOne(from: CDCourseTask.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createCourseTask(daysCode: String? = nil,
                                 editable: Bool,
                                 frequencyType: String? = nil,
                                 infiniteExecution: Bool,
                                 minSanction: Int,
                                 taskAttribute: String? = nil,
                                 taskDescription: String? = nil,
                                 taskName: String? = nil,
                                 taskSanction: Int,
                                 taskType: String? = nil,
                                 courseFk: Int,
                                 tsCreated: Date? = nil,
                                 tsUpdated: Date? = nil) -> CDCourseTask? {
        var newPersonalUser: CDCourseTask? = nil
        do {
            newPersonalUser = try self.perform(synchronous: { (transaction) -> CDCourseTask in
                let user = transaction.create(Into<CDCourseTask>())
                user.id = sId()
                user.daysCode = daysCode
                user.editable = editable
                user.infiniteExecution = infiniteExecution
                user.minSanction = Int64(minSanction)
                user.taskAttribute = taskAttribute
                user.taskDescription = taskDescription
                user.taskName = taskName
                user.taskSanction = Int64(taskSanction)
                user.taskType = taskType
                user.courseFk = Int64(courseFk)
                user.tsCreated = Date()
                user.tsUpdated = Date()
                return user
            })
        } catch {
            print("\(CDCourseTask.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdPersonalUser = newPersonalUser else {
            return nil
        }

        return self.fetchExisting(createdPersonalUser)
    }

    @discardableResult
    public func updateCourseTask(courseTaskId: Int,
                                 daysCode: String? = nil,
                                 editable: Bool? = nil,
                                 frequencyType: String? = nil,
                                 infiniteExecution: Bool? = nil,
                                 minSanction: Int? = nil,
                                 taskAttribute: String? = nil,
                                 taskDescription: String? = nil,
                                 taskName: String? = nil,
                                 taskSanction: Int? = nil,
                                 taskType: String? = nil,
                                 courseFk: Int? = nil) -> CDCourseTask? {

        var newCourseTask: CDCourseTask? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[daysCode, editable]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newCourseTask = try self.perform(synchronous: { (transaction) -> CDCourseTask in
                guard let courseTask = try transaction.fetchOne(From<CDCourseTask>().where(\.id == Int64(courseTaskId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let daysCode = daysCode {
                    courseTask.daysCode = daysCode
                }

                if let editable = editable {
                    courseTask.editable = editable
                }

                if let frequencyType = frequencyType {
                    courseTask.frequencyType = frequencyType
                }

                if let minSanction = minSanction {
                    courseTask.minSanction = Int64(minSanction)
                }

                if let infiniteExecution = infiniteExecution {
                    courseTask.infiniteExecution = infiniteExecution
                }

                if let taskAttribute = taskAttribute {
                    courseTask.taskAttribute = taskAttribute
                }

                if let taskDescription = taskDescription {
                    courseTask.taskDescription = taskDescription
                }

                if let taskName = taskName {
                    courseTask.taskName = taskName
                }

                if let taskSanction = taskSanction {
                    courseTask.taskSanction = Int64(taskSanction)
                }

                if let taskType = taskType {
                    courseTask.taskType = taskType
                }

                if let courseFk = courseFk {
                    courseTask.courseFk = Int64(courseFk)
                }

                if let taskType = taskType {
                    courseTask.taskType = taskType
                }

                if let courseFk = courseFk {
                    courseTask.courseFk = Int64(courseFk)
                }
                
                courseTask.tsUpdated = Date()

                return courseTask
            })
        } catch {
            print("\(CDCourseTask.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedCourseTask = newCourseTask else {
            return nil
        }

        return self.fetchExisting(updatedCourseTask)
    }

    public func deleteCourseTask(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDCourseTask>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDCourseTask.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
