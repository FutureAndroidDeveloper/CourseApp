//
//  ATYDatabaseService+CDTransaction.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 .... All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getTransaction(id: Int) -> CDTransaction? {
        return self.fetchOne(from: CDTransaction.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createTransaction(amount: Int,
                                  internalCurrency: String? = nil,
                                  purchaseId: Int,
                                  purchaseType: String? = nil,
                                  sanctionId: Int,
                                  storeInformation: String? = nil,
                                  transactionDate: Date? = nil,
                                  transactionInfo: String? = nil,
                                  transactionType: String? = nil,
                                  userAchievementId: Int,
                                  validationType: String? = nil,
                                  walletFk: Int) -> CDTransaction? {
        var newTransaction: CDTransaction? = nil
        do {
            newTransaction = try self.perform(synchronous: { (transaction) -> CDTransaction in
                let transaction = transaction.create(Into<CDTransaction>())
                transaction.id = sId()
                transaction.amount = Int64(amount)
                transaction.internalCurrency = internalCurrency
                transaction.purchaseId = Int64(purchaseId)
                transaction.sanctionId = Int64(sanctionId)
                transaction.storeInformation = storeInformation
                transaction.userAchievementId = Int64(userAchievementId)
                transaction.transactionDate = transactionDate
                transaction.transactionInfo = transactionInfo
                transaction.transactionType = transactionType
                transaction.validationType = validationType
                transaction.purchaseType = purchaseType
                transaction.walletFk = Int64(walletFk)
                transaction.tsCreated = Date()
                transaction.tsUpdated = Date()
                return transaction
            })
        } catch {
            print("\(CDTransaction.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdTransaction = newTransaction else {
            return nil
        }

        return self.fetchExisting(createdTransaction)
    }

    @discardableResult
    public func updateTransaction(transactionId: Int,
                                  amount: Int? = nil,
                                  internalCurrency: String? = nil,
                                  purchaseId: Int? = nil,
                                  purchaseType: String? = nil,
                                  sanctionId: Int? = nil,
                                  storeInformation: String? = nil,
                                  transactionDate: Date? = nil,
                                  transactionInfo: String? = nil,
                                  transactionType: String? = nil,
                                  userAchievementId: Int? = nil,
                                  validationType: String? = nil,
                                  walletFk: Int? = nil) -> CDTransaction? {

        var newTransaction: CDTransaction? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[amount, internalCurrency]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newTransaction = try self.perform(synchronous: { (transaction) -> CDTransaction in
                guard let transaction = try transaction.fetchOne(From<CDTransaction>().where(\.id == Int64(transactionId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let amount = amount {
                    transaction.amount = Int64(amount)
                }

                if let purchaseId = purchaseId {
                    transaction.purchaseId = Int64(purchaseId)
                }

                if let internalCurrency = internalCurrency {
                    transaction.internalCurrency = internalCurrency
                }

                if let purchaseType = purchaseType {
                    transaction.purchaseType = purchaseType
                }

                if let sanctionId = sanctionId {
                    transaction.sanctionId = Int64(sanctionId)
                }

                if let storeInformation = storeInformation {
                    transaction.storeInformation = storeInformation
                }

                if let transactionDate = transactionDate {
                    transaction.transactionDate = transactionDate
                }

                if let transactionInfo = transactionInfo {
                    transaction.transactionInfo = transactionInfo
                }

                if let transactionInfo = transactionInfo {
                    transaction.transactionInfo = transactionInfo
                }

                if let transactionType = transactionType {
                    transaction.transactionType = transactionType
                }

                if let userAchievementId = userAchievementId {
                    transaction.userAchievementId = Int64(userAchievementId)
                }

                if let validationType = validationType {
                    transaction.validationType = validationType
                }

                if let walletFk = walletFk {
                    transaction.walletFk = Int64(walletFk)
                }

                transaction.tsUpdated = Date()

                return transaction
            })
        } catch {
            print("\(CDTransaction.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedTransaction = newTransaction else {
            return nil
        }

        return self.fetchExisting(updatedTransaction)
    }

    public func deleteTransaction(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDTransaction>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDTransaction.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
