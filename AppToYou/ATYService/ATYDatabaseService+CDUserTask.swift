//
//  ATYDatabaseService+CDUserTask.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getUserTask(id: Int) -> CDUserTask? {
        return self.fetchOne(from: CDUserTask.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    public func getAllUserTasks() -> [CDUserTask]? {
        return self.fetchAll(from: CDUserTask.self)
    }

    @discardableResult
    public func createUserTask(courseTaskId: Int? = nil,
                               daysCode: String? = nil,
                               editableCourseTask: Bool,
                               frequencyType: String,
                               minimumCourseTaskSanction: Int,
                               taskAttribute: String? = nil,
                               startDate: Date,
                               taskCompleteTime: Date? = nil,
                               taskDescription: String? = nil,
                               taskName: String,
                               taskSanction: Int,
                               taskType: String,
                               courseFk: Int?,
                               userFk: Int? = nil) -> CDUserTask? {
        var newUserTask: CDUserTask? = nil
        do {
            newUserTask = try self.perform(synchronous: { (transaction) -> CDUserTask in
                let userTask = transaction.create(Into<CDUserTask>())
                userTask.id = sId()
                userTask.courseTaskId = courseTaskId == nil ? nil : Int64(courseTaskId!)
                userTask.daysCode = daysCode
                userTask.editableCourseTask = editableCourseTask
                userTask.frequencyType = frequencyType
                userTask.taskAttribute = taskAttribute
                userTask.minimumCourseTaskSanction = Int64(minimumCourseTaskSanction)
                userTask.startDate = startDate
                userTask.taskCompleteTime = taskCompleteTime
                userTask.taskDescription = taskDescription
                userTask.taskName = taskName
                userTask.taskType = taskType
                userTask.taskSanction = Int64(taskSanction)
                userTask.courseFk = courseFk == nil ? nil : Int64(courseFk!)
                userTask.userFk = courseFk == nil ? nil : Int64(userFk!)
                userTask.tsCreated = Date()
                userTask.tsUpdated = Date()
                return userTask
            })
        } catch {
            print("\(CDUserTask.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdUserTask = newUserTask else {
            return nil
        }

        return self.fetchExisting(createdUserTask)
    }

    @discardableResult
    public func updateUserTask(userTaskId: Int,
                               daysCode: String? = nil,
                               editableCourseTask: Bool? = nil,
                               frequencyType: String? = nil,
                               minimumCourseTaskSanction: Int? = nil,
                               taskAttribute: String? = nil,
                               startDate: Date? = nil,
                               taskCompleteTime: Date? = nil,
                               taskDescription: String? = nil,
                               taskName: String? = nil,
                               taskSanction: Int? = nil,
                               taskType: String? = nil,
                               courseFk: Int? = nil,
                               userFk: Int? = nil) -> CDUserTask? {

        var newUserTask: CDUserTask? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[daysCode, editableCourseTask]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newUserTask = try self.perform(synchronous: { (transaction) -> CDUserTask in
                guard let userTask = try transaction.fetchOne(From<CDUserTask>().where(\.id == Int64(userTaskId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let daysCode = daysCode {
                    userTask.daysCode = daysCode
                }

                if let editableCourseTask = editableCourseTask {
                    userTask.editableCourseTask = editableCourseTask
                }

                if let frequencyType = frequencyType {
                    userTask.frequencyType = frequencyType
                }

                if let minimumCourseTaskSanction = minimumCourseTaskSanction {
                    userTask.minimumCourseTaskSanction = Int64(minimumCourseTaskSanction)
                }

                if let taskAttribute = taskAttribute {
                    userTask.taskAttribute = taskAttribute
                }

                if let startDate = startDate {
                    userTask.startDate = startDate
                }

                if let taskCompleteTime = taskCompleteTime {
                    userTask.taskCompleteTime = taskCompleteTime
                }

                if let taskDescription = taskDescription {
                    userTask.taskDescription = taskDescription
                }

                if let taskName = taskName {
                    userTask.taskName = taskName
                }

                if let taskSanction = taskSanction {
                    userTask.taskSanction = Int64(taskSanction)
                }

                if let taskType = taskType {
                    userTask.taskType = taskType
                }

                if let courseFk = courseFk {
                    userTask.courseFk = Int64(courseFk)
                }

                if let userFk = userFk {
                    userTask.userFk = Int64(userFk)
                }

                userTask.tsUpdated = Date()

                return userTask
            })
        } catch {
            print("\(CDUserTask.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedUserTask = newUserTask else {
            return nil
        }

        return self.fetchExisting(updatedUserTask)
    }

    public func deleteUserTask(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDUserTask>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDUserTask.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
