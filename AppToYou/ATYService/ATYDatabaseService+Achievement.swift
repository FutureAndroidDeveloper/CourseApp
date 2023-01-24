//
//  ATYDatabaseService+Achievement.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getAchievement(id: Int) -> CDAchievement? {
        return self.fetchOne(from: CDAchievement.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createAchievement(type: String? = nil,
                                  attribute: Int,
                                  bonus: Int,
                                  descriptionName: String? = nil,
                                  name: String? = nil,
                                  range: Int) -> CDAchievement? {
        var newUserAchievement: CDAchievement? = nil
        do {
            newUserAchievement = try self.perform(synchronous: { (transaction) -> CDAchievement in
                let user = transaction.create(Into<CDAchievement>())
                user.id = sId()
                user.descriptionName = descriptionName
                user.name = name
                user.type = type
                user.range = Int64(range)
                user.bonus = Int64(bonus)
                user.attribute = Int64(attribute)
                user.tsCreated = Date()
                user.tsUpdated = Date()
                return user
            })
        } catch {
            print("\(CDAchievement.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdUserAchievement = newUserAchievement else {
            return nil
        }

        return self.fetchExisting(createdUserAchievement)
    }

    @discardableResult
    public func updateAchievement(achievemntId: Int,
                                  type: String? = nil,
                                  attribute: Int? = nil,
                                  bonus: Int? = nil,
                                  descriptionName: String? = nil,
                                  name: String? = nil,
                                  range: Int? = nil) -> CDAchievement? {

        var newAchievement: CDAchievement? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[type, attribute]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newAchievement = try self.perform(synchronous: { (transaction) -> CDAchievement in
                guard let user = try transaction.fetchOne(From<CDAchievement>().where(\.id == Int64(achievemntId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let type = type {
                    user.type = type
                }

                if let attribute = attribute {
                    user.attribute = Int64(attribute)
                }

                if let descriptionName = descriptionName {
                    user.descriptionName = descriptionName
                }

                if let name = name {
                    user.name = name
                }

                if let bonus = bonus {
                    user.bonus = Int64(bonus)
                }

                if let range = range {
                    user.range = Int64(range)
                }

                user.tsUpdated = Date()

                return user
            })
        } catch {
            print("\(CDAchievement.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedAchievement = newAchievement else {
            return nil
        }

        return self.fetchExisting(updatedAchievement)
    }

    public func deleteAchievement(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDAchievement>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDAchievement.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
