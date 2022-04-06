import Foundation

enum PurchaseType: String, Encodable {
    case INTERNAL_COURSE, COURSE, COINS
}

enum TransactionType: String, Encodable {
    case PURCHASE, ACHIEVEMENT_BONUS, PAYOUT, SANCTION, RECEIPT
}

class TransactionRequest: Encodable {
    let amount: Int?
    let internalCurrency: CourseTaskCurrency?
    let phoneSanctionId: Int?
    let purchaseId: Int?
    let purchaseType: PurchaseType?
    let sanctionId: Int?
    let storeInformation: String?
    let transactionDate: String?
    let transactionInfo: String?
    let transactionType: TransactionType?
    let userAchievementId: Int?
    
    init(
        amount: Int? = nil, internalCurrency: CourseTaskCurrency? = nil, phoneSanctionId: Int? = nil, purchaseId: Int? = nil,
        purchaseType: PurchaseType? = nil, sanctionId: Int? = nil, storeInformation: String? = nil, transactionDate: String? = nil,
        transactionInfo: String? = nil, transactionType: TransactionType? = nil, userAchievementId: Int? = nil
    ) {
        self.amount = amount
        self.internalCurrency = internalCurrency
        self.phoneSanctionId = phoneSanctionId
        self.purchaseId = purchaseId
        self.purchaseType = purchaseType
        self.sanctionId = sanctionId
        self.storeInformation = storeInformation
        self.transactionDate = transactionDate
        self.transactionInfo = transactionInfo
        self.transactionType = transactionType
        self.userAchievementId = userAchievementId
    }
}
