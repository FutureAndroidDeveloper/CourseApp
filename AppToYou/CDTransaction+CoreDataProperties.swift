//
//  CDTransaction+CoreDataProperties.swift
//  AppToYou
//
//  Created by Philip Bratov on 24.06.2021.
//  Copyright © 2021 .... All rights reserved.
//
//

import Foundation
import CoreData


extension CDTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTransaction> {
        return NSFetchRequest<CDTransaction>(entityName: "CDTransaction")
    }

    @NSManaged public var tsCreated: Date?
    @NSManaged public var tsUpdated: Date?
    @NSManaged public var amount: Int64
    @NSManaged public var internalCurrency: String?
    @NSManaged public var purchaseId: Int64
    @NSManaged public var purchaseType: String?
    @NSManaged public var sanctionId: Int64
    @NSManaged public var storeInformation: String?
    @NSManaged public var transactionDate: Date?
    @NSManaged public var transactionInfo: String?
    @NSManaged public var transactionType: String?
    @NSManaged public var userAchievementId: Int64
    @NSManaged public var validationType: String?
    @NSManaged public var walletFk: Int64
    @NSManaged public var id: Int64
    var backId: Int64? {
        get {
            self.willAccessValue(forKey: "backId")
            let value = self.primitiveValue(forKey: "backId") as? Int
            self.didAccessValue(forKey: "backId")

            return (value != nil) ? Int64(value!) : nil
        }
        set {
            self.willChangeValue(forKey: "backId")

            let value : Int? = (newValue != nil) ? Int(newValue!) : nil
            self.setPrimitiveValue(value, forKey: "backId")

            self.didChangeValue(forKey: "backId")
        }
    }

}

extension CDTransaction : Identifiable {

}
