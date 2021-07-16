//
//  ATYDatabaseService+CDCourse.swift
//  AppToYou
//
//  Created by Philip Bratov on 29.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import Foundation
import CoreStore

extension ATYDatabaseService {

    public func getCourse(id: Int) -> CDCourse? {
        return self.fetchOne(from: CDCourse.self, where: NSPredicate(format: "id == %d", Int64(id)))
    }

    @discardableResult
    public func createCourse(
                             chatEnabled: Bool,
                             chatPath: String? = nil,
                           cost: Int,
                           courseTypeCode: Int,
                           courseDescription: String? = nil,
                           durationType: String? = nil,
                           isInternal: Bool,
                           isOpen: Bool,
                           likes: Int,
                           courseName: String? = nil,
                           picPath: String? = nil,
                           privacyEnabled: Bool,
                           publicId: String? = nil,
                           usersAmount: Int,
                           adminFk: Int) -> CDCourse? {
        var newPersonalUser: CDCourse? = nil
        do {
            newPersonalUser = try self.perform(synchronous: { (transaction) -> CDCourse in
                let user = transaction.create(Into<CDCourse>())
                user.id = sId()
                user.chatEnabled = chatEnabled
                user.chatPath = chatPath
                user.picPath = picPath
                user.cost = Int64(cost)
                user.courseTypeCode = Int64(courseTypeCode)
                user.courseDescription = courseDescription
                user.durationType = durationType
                user.isInternal = isInternal
                user.isOpen = isOpen
                user.likes = Int64(likes)
                user.courseName = courseName
                user.privacyEnabled = privacyEnabled
                user.publicId = publicId
                user.usersAmount = Int64(usersAmount)
                user.adminFk = Int64(adminFk)
                user.tsCreated = Date()
                user.tsUpdated = Date()
                return user
            })
        } catch {
            print("\(CDCourse.description()) was not created by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let createdPersonalUser = newPersonalUser else {
            return nil
        }

        return self.fetchExisting(createdPersonalUser)
    }

    @discardableResult
    public func updateCourse(courseId: Int,
                             chatEnabled: Bool? = nil,
                             chatPath: String? = nil,
                             cost: Int? = nil,
                             courseTypeCode: Int? = nil,
                             courseDescription: String? = nil,
                             durationType: String? = nil,
                             isInternal: Bool? = nil,
                             isOpen: Bool? = nil,
                             likes: Int? = nil,
                             courseName: String? = nil,
                             picPath: String? = nil,
                             privacyEnabled: Bool? = nil,
                             publicId: String? = nil,
                             usersAmount: Int? = nil,
                             adminFk: Int? = nil,
                             backId: Int64? = nil) -> CDCourse? {

        var newCourse: CDCourse? = nil
        // if all of updated parameters are nil transaction will not be performed
        guard transactionShouldBePerformed(with:[chatEnabled, chatPath]) else {
            print("No parameter for updating the entity was passed")
            return nil
        }
        do {
            newCourse = try self.perform(synchronous: { (transaction) -> CDCourse in
                guard let course = try transaction.fetchOne(From<CDCourse>().where(\.id == Int64(courseId))) else {
                    throw ATYDatabaseServiceError.uncategorized
                }

                if let chatEnabled = chatEnabled {
                    course.chatEnabled = chatEnabled
                }

                if let chatPath = chatPath {
                    course.chatPath = chatPath
                }

                if let cost = cost {
                    course.cost = Int64(cost)
                }

                if let courseTypeCode = courseTypeCode {
                    course.courseTypeCode = Int64(courseTypeCode)
                }

                if let courseDescription = courseDescription {
                    course.courseDescription = courseDescription
                }

                if let durationType = durationType {
                    course.durationType = durationType
                }

                if let isOpen = isOpen {
                    course.isOpen = isOpen
                }

                if let likes = likes {
                    course.likes = Int64(likes)
                }

                if let courseName = courseName {
                    course.courseName = courseName
                }

                if let picPath = picPath {
                    course.picPath = picPath
                }

                if let privacyEnabled = privacyEnabled {
                    course.privacyEnabled = privacyEnabled
                }

                if let publicId = publicId {
                    course.publicId = publicId
                }

                if let usersAmount = usersAmount {
                    course.usersAmount = Int64(usersAmount)
                }

                if let adminFk = adminFk {
                    course.adminFk = Int64(adminFk)
                }

                course.tsUpdated = Date()

                return course
            })
        } catch {
            print("\(CDCourse.description()) was not updated by synchronous task by reason of error: " + error.localizedDescription)
        }

        guard let updatedCourse = newCourse else {
            return nil
        }

        return self.fetchExisting(updatedCourse)
    }

    public func deleteCourse(id: Int){
        do {
            try self.perform(synchronous: { (transaction) -> Void in
                let user = try transaction.fetchOne(From<CDCourse>().where(\.id == Int64(id)))
                transaction.delete(user)
            })
        } catch {
            print("\(CDCourse.description()) was not deleted by synchronous task by reason of error: " + error.localizedDescription)
        }
    }
}
