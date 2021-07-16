//
//  ATYDatabaseService+CDStatistics.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getStatistics(id: Int) -> CDStatistics? {
        return self.fetchOne(from: CDStatistics.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createStatistics(coinsSpent: Int,
                                 createdCoursesAmount: Int,
                                 currentDaysSeries: Int,
                                 finishedCoursesAmount: Int,
                                 invitedFriendsToTheCourses: Int,
                                 maxCompletedTasksPerDay: Int,
                                 maxDaysSeries: Int) -> CDStatistics? {
        var newStatistics: CDStatistics? = nil
        do {
            newStatistics = try self.perform(synchronous: { (transaction) -> CDStatistics in
                let statistics = transaction.create(Into<CDStatistics>())
                statistics.id = sId()
                statistics.coinsSpent = Int64(coinsSpent)
                statistics.createdCoursesAmount = Int64(createdCoursesAmount)
                statistics.currentDaysSeries = Int64(currentDaysSeries)
                statistics.finishedCoursesAmount = Int64(finishedCoursesAmount)
                statistics.invitedFriendsToTheCourses = Int64(invitedFriendsToTheCourses)
                statistics.maxCompletedTasksPerDay = Int64(maxCompletedTasksPerDay)
                statistics.maxDaysSeries = Int64(maxDaysSeries)
                statistics.tsCreated = Date()
                statistics.tsUpdated = Date()
                return statistics
            })
        } catch {
            print("\(CDStatistics.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdStatistics = newStatistics else {
            return nil
        }

        return self.fetchExisting(createdStatistics)
    }

    @discardableResult
    public func updateStatics(statisticsId: Int,
                              coinsSpent: Int? = nil,
                              createdCoursesAmount: Int? = nil,
                              currentDaysSeries: Int? = nil,
                              finishedCoursesAmount: Int? = nil,
                              invitedFriendsToTheCourses: Int? = nil,
                              maxCompletedTasksPerDay: Int? = nil,
                              maxDaysSeries: Int? = nil) -> CDStatistics? {

        var newStatistics: CDStatistics? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[coinsSpent, statisticsId]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newStatistics = try self.perform(synchronous: { (transaction) -> CDStatistics in
                guard let statistics = try transaction.fetchOne(From<CDStatistics>().where(\.id == Int64(statisticsId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let coinsSpent = coinsSpent {
                    statistics.coinsSpent = Int64(coinsSpent)
                }

                if let createdCoursesAmount = createdCoursesAmount {
                    statistics.createdCoursesAmount = Int64(createdCoursesAmount)
                }

                if let currentDaysSeries = currentDaysSeries {
                    statistics.currentDaysSeries = Int64(currentDaysSeries)
                }

                if let finishedCoursesAmount = finishedCoursesAmount {
                    statistics.finishedCoursesAmount = Int64(finishedCoursesAmount)
                }

                if let invitedFriendsToTheCourses = invitedFriendsToTheCourses {
                    statistics.invitedFriendsToTheCourses = Int64(invitedFriendsToTheCourses)
                }

                if let maxCompletedTasksPerDay = maxCompletedTasksPerDay {
                    statistics.maxCompletedTasksPerDay = Int64(maxCompletedTasksPerDay)
                }

                if let maxDaysSeries = maxDaysSeries {
                    statistics.maxDaysSeries = Int64(maxDaysSeries)
                }

                statistics.tsUpdated = Date()

                return statistics
            })
        } catch {
            print("\(CDStatistics.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedStatistics = newStatistics else {
            return nil
        }

        return self.fetchExisting(updatedStatistics)
    }

    public func deleteStatistics(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDStatistics>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDStatistics.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
