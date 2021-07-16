//
//  ATYDatabaseService+CDUserAchievement.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getUserAchievement(id: Int) -> CDUserAchievement? {
        return self.fetchOne(from: CDUserAchievement.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createUserAchievement(completionDate: Date? = nil,
                                      achievementFk: Int,
                                      userFk: Int) -> CDUserAchievement? {
        var newUserAchievement: CDUserAchievement? = nil
        do {
            newUserAchievement = try self.perform(synchronous: { (transaction) -> CDUserAchievement in
                let user = transaction.create(Into<CDUserAchievement>())
                user.id = sId()
                user.completionDate = completionDate
                user.achievementFk = Int64(achievementFk)
                user.userFk = Int64(userFk)
                user.tsCreated = Date()
                user.tsUpdated = Date()
                return user
            })
        } catch {
            print("\(CDUserAchievement.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdUserAchievement = newUserAchievement else {
            return nil
        }

        return self.fetchExisting(createdUserAchievement)
    }

    @discardableResult
    public func updateUserAchievement(userAchievemntId: Int,
                                      completionDate: Date? = nil,
                                      achievementFk: Int? = nil,
                                      userFk: Int? = nil) -> CDUserAchievement? {

        var newUserAchievement: CDUserAchievement? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[completionDate, achievementFk]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newUserAchievement = try self.perform(synchronous: { (transaction) -> CDUserAchievement in
                guard let user = try transaction.fetchOne(From<CDUserAchievement>().where(\.id == Int64(userAchievemntId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let completionDate = completionDate {
                    user.completionDate = completionDate
                }

                if let achievementFk = achievementFk {
                    user.achievementFk = Int64(achievementFk)
                }

                if let userFk = userFk {
                    user.userFk = Int64(userFk)
                }

                user.tsUpdated = Date()

                return user
            })
        } catch {
            print("\(CDUserAchievement.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedUserAchievement = newUserAchievement else {
            return nil
        }

        return self.fetchExisting(updatedUserAchievement)
    }

    public func deleteUserAchievement(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDUserAchievement>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDUserAchievement.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
