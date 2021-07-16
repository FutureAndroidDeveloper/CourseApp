//
//  ATYDatabaseService+CDStore.swift
//  AppToYou
//
//  Created by Philip Bratov on 30.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getStore(id: Int) -> CDStore? {
        return self.fetchOne(from: CDStore.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createStore(coinsAmount: Int,
                               currency: String? = nil,
                               price: Int) -> CDStore? {
        var newStore: CDStore? = nil
        do {
            newStore = try self.perform(synchronous: { (transaction) -> CDStore in
                let store = transaction.create(Into<CDStore>())
                store.id = sId()
                store.coinsAmount = Int64(coinsAmount)
                store.currency = currency
                store.price = Int64(price)
                store.tsCreated = Date()
                store.tsUpdated = Date()
                return store
            })
        } catch {
            print("\(CDStore.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdStore = newStore else {
            return nil
        }

        return self.fetchExisting(createdStore)
    }

    @discardableResult
    public func updateStore(storeId: Int,
                            coinsAmount: Int? = nil,
                            currency: String? = nil,
                            price: Int? = nil) -> CDStore? {

        var newStore: CDStore? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[coinsAmount, currency]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newStore = try self.perform(synchronous: { (transaction) -> CDStore in
                guard let store = try transaction.fetchOne(From<CDStore>().where(\.id == Int64(storeId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let currency = currency {
                    store.currency = currency
                }

                if let coinsAmount = coinsAmount {
                    store.coinsAmount = Int64(coinsAmount)
                }

                if let price = price {
                    store.price = Int64(price)
                }

                store.tsUpdated = Date()

                return store
            })
        } catch {
            print("\(CDStore.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedStore = newStore else {
            return nil
        }

        return self.fetchExisting(updatedStore)
    }

    public func deleteStore(id: Int) {
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDStore>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDStore.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
