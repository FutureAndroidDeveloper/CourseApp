//
//  ATYDatabaseService+CDCourseUser.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getCourseUser(id: Int) -> CDCourseUser? {
        return self.fetchOne(from: CDCourseUser.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createCourseUser(completedTasksAmount: Int = 0,
                                 currentSeries: Int = 0,
                                 isFinished: Bool,
                                 isPrivateForUser: Bool,
                                 likeIt: Bool,
                                 maxSeries: Int = 0,
                                 personalRaiting: Int = 0,
                                 sanctionsAmount: Int = 0,
                                 userStatusCode: Int = 0,
                                 courseFk: Int,
                                 invitationFromFk: Int = 0) -> CDCourseUser? {
        var newCourseUser: CDCourseUser? = nil
        do {
            newCourseUser = try self.perform(synchronous: { (transaction) -> CDCourseUser in
                let user = transaction.create(Into<CDCourseUser>())
                user.id = sId()
                user.completedTasksAmount = Int64(completedTasksAmount)
                user.currentSeries = Int64(currentSeries)
                user.userStatusCode = Int64(userStatusCode)
                user.sanctionsAmount = Int64(sanctionsAmount)
                user.personalRaiting = Int64(personalRaiting)
                user.maxSeries = Int64(maxSeries)
                user.likeIt = likeIt
                user.isPrivateForUser = isPrivateForUser
                user.isFinished = isFinished
                user.courseFk = Int64(courseFk)
                user.invitationFromFk =  Int64(invitationFromFk)
                user.tsCreated = Date()
                user.tsUpdated = Date()
                return user
            })
        } catch {
            print("\(CDCourseUser.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdCourseUser = newCourseUser else {
            return nil
        }

        return self.fetchExisting(createdCourseUser)
    }

    @discardableResult
    public func updateCourseUser(courseUserId: Int,
                                 completedTasksAmount: Int? = nil,
                                 currentSeries: Int? = nil,
                                 isFinished: Bool? = nil,
                                 isPrivateForUser: Bool? = nil,
                                 likeIt: Bool? = nil,
                                 maxSeries: Int? = nil,
                                 personalRaiting: Int? = nil,
                                 sanctionsAmount: Int? = nil,
                                 userStatusCode: Int? = nil,
                                 courseFk: Int? = nil,
                                 invitationFromFk: Int? = nil) -> CDCourseUser? {

        var newCourseUser: CDCourseUser? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[courseUserId, completedTasksAmount]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newCourseUser = try self.perform(synchronous: { (transaction) -> CDCourseUser in
                guard let courseUser = try transaction.fetchOne(From<CDCourseUser>().where(\.id == Int64(courseUserId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let completedTasksAmount = completedTasksAmount {
                    courseUser.completedTasksAmount = Int64(completedTasksAmount)
                }

                if let currentSeries = currentSeries {
                    courseUser.currentSeries = Int64(currentSeries)
                }

                if let isFinished = isFinished {
                    courseUser.isFinished = isFinished
                }

                if let isPrivateForUser = isPrivateForUser {
                    courseUser.isPrivateForUser = isPrivateForUser
                }

                if let likeIt = likeIt {
                    courseUser.likeIt = likeIt
                }

                if let maxSeries = maxSeries {
                    courseUser.maxSeries = Int64(maxSeries)
                }

                if let personalRaiting = personalRaiting {
                    courseUser.personalRaiting =  Int64(personalRaiting)
                }

                if let sanctionsAmount = sanctionsAmount {
                    courseUser.sanctionsAmount = Int64(sanctionsAmount)
                }

                if let userStatusCode = userStatusCode {
                    courseUser.userStatusCode = Int64(userStatusCode)
                }

                if let courseFk = courseFk {
                    courseUser.courseFk = Int64(courseFk)
                }

                if let invitationFromFk = invitationFromFk {
                    courseUser.invitationFromFk = Int64(invitationFromFk)
                }

                courseUser.tsUpdated = Date()

                return courseUser
            })
        } catch {
            print("\(CDCourseUser.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedCourseUser = newCourseUser else {
            return nil
        }

        return self.fetchExisting(updatedCourseUser)
    }

    public func deleteCourseUser(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDCourseUser>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDCourseTask.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}

