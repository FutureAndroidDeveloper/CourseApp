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

    public func getUser() -> CDUser? {
        return self.fetchOne(from: CDUser.self)
    }

    @discardableResult
    public func createUser(name: String,
                           avatarPath: String? = nil,
                           tsCreated: Date? = nil,
                           tsUpdated: Date? = nil,
                           uuid: String? = nil, password: String, email: String
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
                user.uuid = uuid
                user.password = password
                user.loginEmail = email
                
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

}
