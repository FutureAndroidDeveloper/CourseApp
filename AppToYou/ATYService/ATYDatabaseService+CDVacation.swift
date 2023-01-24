//
//  ATYDatabaseService+CDVacation.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getVacation(id: Int) -> CDVacation? {
        return self.fetchOne(from: CDVacation.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createVacation(startDate: Date? = nil,
                               endDate: Date? = nil,
                                      userFk: Int) -> CDVacation? {
        var newVacation: CDVacation? = nil
        do {
            newVacation = try self.perform(synchronous: { (transaction) -> CDVacation in
                let vacation = transaction.create(Into<CDVacation>())
                vacation.id = sId()
                vacation.endDate = endDate
                vacation.startDate = startDate
                vacation.userFk = Int64(userFk)
                vacation.tsCreated = Date()
                vacation.tsUpdated = Date()
                return vacation
            })
        } catch {
            print("\(CDVacation.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdVacation = newVacation else {
            return nil
        }

        return self.fetchExisting(createdVacation)
    }

    @discardableResult
    public func updateVacation(vacationId: Int,
                               startDate: Date? = nil,
                               endDate: Date? = nil,
                               userFk: Int? = nil) -> CDVacation? {

        var newUserAchievement: CDVacation? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[startDate, endDate]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newUserAchievement = try self.perform(synchronous: { (transaction) -> CDVacation in
                guard let vacation = try transaction.fetchOne(From<CDVacation>().where(\.id == Int64(vacationId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let startDate = startDate {
                    vacation.startDate = startDate
                }

                if let endDate = endDate {
                    vacation.endDate = endDate
                }

                if let userFk = userFk {
                    vacation.userFk = Int64(userFk)
                }

                vacation.tsUpdated = Date()

                return vacation
            })
        } catch {
            print("\(CDVacation.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedUserAchievement = newUserAchievement else {
            return nil
        }

        return self.fetchExisting(updatedUserAchievement)
    }

    public func deleteVacation(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDVacation>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDVacation.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}

