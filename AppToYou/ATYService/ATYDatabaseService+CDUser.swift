//
//  ATYDatabaseService+CDUser.swift
//  AppToYou
//
//  Created by Philip Bratov on 21.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getUser(id: Int) -> CDUser? {
        return self.fetchOne(from: CDUser.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createUser(name: String,
                           avatarPath: String? = nil,
                           tsCreated: Date? = nil,
                           tsUpdated: Date? = nil,
                           authentification: String?, password: String, email: String
    ) -> CDUser? {
        var newPersonalUser: CDUser? = nil
        do {
            newPersonalUser = try self.perform(synchronous: { (transaction) -> CDUser in
                let user = transaction.create(Into<CDUser>())
                user.id = sId()
                user.name = name
                user.avatarPath = avatarPath
                user.tsCreated = tsCreated
                user.tsUpdated = tsUpdated
                user.password = password
                user.loginEmail = email
                user.authentification = authentification
                
                return user
            })
        } catch {
            print("\(CDUser.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdPersonalUser = newPersonalUser else {
            return nil
        }

        return self.fetchExisting(createdPersonalUser)
    }

    @discardableResult
    public func updateUser(userId: Int,
                           updatedName name: String? = nil,
                           updatedAuthentification: String? = nil,
                           updatedAvatarPath avatarPath: String? = nil) -> CDUser? {

        var newPersonalUser: CDUser? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[name, avatarPath]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newPersonalUser = try self.perform(synchronous: { (transaction) -> CDUser in
                guard let person = try transaction.fetchOne(From<CDUser>().where(\.id == Int64(userId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let updatedName = name {
                    person.name = updatedName
                }

                if let updatedAuthentification = updatedAuthentification {
                    person.authentification = updatedAuthentification
                }


                if let updatedAvatarPath = avatarPath {
                    person.avatarPath = updatedAvatarPath
                }

                person.tsUpdated = Date()

                return person
            })
        } catch {
            print("\(CDUser.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedPersonalUser = newPersonalUser else {
            return nil
        }

        return self.fetchExisting(updatedPersonalUser)
    }

    public func deleteUser(id: Int){
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDUser>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDUser.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }

}
