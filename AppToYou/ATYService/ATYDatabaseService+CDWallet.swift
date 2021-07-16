//
//  ATYDatabaseService+CDWallet.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getWallet(id: Int) -> CDWallet? {
        return self.fetchOne(from: CDWallet.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createWallet(coinsAmount: Int,
                             diamondsAmount: Int) -> CDWallet? {
        var newWallet: CDWallet? = nil
        do {
            newWallet = try self.perform(synchronous: { (transaction) -> CDWallet in
                let wallet = transaction.create(Into<CDWallet>())
                wallet.id = sId()
                wallet.coinsAmount = Int64(coinsAmount)
                wallet.diamondsAmount = Int64(diamondsAmount)
                wallet.tsCreated = Date()
                wallet.tsUpdated = Date()
                return wallet
            })
        } catch {
            print("\(CDWallet.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdWallet = newWallet else {
            return nil
        }

        return self.fetchExisting(createdWallet)
    }

    @discardableResult
    public func updateWallet(walletId: Int,
                             coinsAmount: Int? = nil,
                             diamondsAmount: Int? = nil) -> CDWallet? {

        var newWallet: CDWallet? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[coinsAmount, diamondsAmount]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newWallet = try self.perform(synchronous: { (transaction) -> CDWallet in
                guard let wallet = try transaction.fetchOne(From<CDWallet>().where(\.id == Int64(walletId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let coinsAmount = coinsAmount {
                    wallet.coinsAmount = Int64(coinsAmount)
                }

                if let diamondsAmount = diamondsAmount {
                    wallet.diamondsAmount = Int64(diamondsAmount)
                }

                wallet.tsUpdated = Date()

                return wallet
            })
        } catch {
            print("\(CDWallet.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedWallet = newWallet else {
            return nil
        }

        return self.fetchExisting(updatedWallet)
    }

    public func deleteWallet(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDWallet>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDWallet.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}


