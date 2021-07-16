//
//  ATYDatabaseService+CDSanction.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getSanction(id: Int) -> CDSanction? {
        return self.fetchOne(from: CDSanction.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createSanction(sanctionDate: Date? = nil,
                               taskSanction: Int,
                               transactionId: Int,
                               userId: Int,
                               wasPayed: Bool,
                               userTaskFk: Int) -> CDSanction? {
        var newSanction: CDSanction? = nil
        do {
            newSanction = try self.perform(synchronous: { (transaction) -> CDSanction in
                let sanction = transaction.create(Into<CDSanction>())
                sanction.id = sId()
                sanction.userId = Int64(userId)
                sanction.wasPayed = wasPayed
                sanction.transactionId = Int64(transactionId)
                sanction.taskSanction = Int64(taskSanction)
                sanction.userTaskFk = Int64(userTaskFk)
                sanction.tsCreated = Date()
                sanction.tsUpdated = Date()
                return sanction
            })
        } catch {
            print("\(CDSanction.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdSanction = newSanction else {
            return nil
        }

        return self.fetchExisting(createdSanction)
    }

    @discardableResult
    public func updateSanction(sanctionId: Int,
                               sanctionDate: Date? = nil,
                               taskSanction: Int? = nil,
                               transactionId: Int? = nil,
                               userId: Int? = nil,
                               wasPayed: Bool? = nil,
                               userTaskFk: Int? = nil) -> CDSanction? {

        var newSanction: CDSanction? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[sanctionDate, taskSanction]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newSanction = try self.perform(synchronous: { (transaction) -> CDSanction in
                guard let sanction = try transaction.fetchOne(From<CDSanction>().where(\.id == Int64(sanctionId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let sanctionDate = sanctionDate {
                    sanction.sanctionDate = sanctionDate
                }

                if let taskSanction = taskSanction {
                    sanction.taskSanction = Int64(taskSanction)
                }

                if let transactionId = transactionId {
                    sanction.transactionId = Int64(transactionId)
                }

                if let userId = userId {
                    sanction.userId = Int64(userId)
                }

                if let wasPayed = wasPayed {
                    sanction.wasPayed = wasPayed
                }

                if let userTaskFk = userTaskFk {
                    sanction.userTaskFk = Int64(userTaskFk)
                }

                sanction.tsUpdated = Date()

                return sanction
            })
        } catch {
            print("\(CDSanction.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedSanction = newSanction else {
            return nil
        }

        return self.fetchExisting(updatedSanction)
    }

    public func deleteSanction(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDSanction>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDSanction.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
