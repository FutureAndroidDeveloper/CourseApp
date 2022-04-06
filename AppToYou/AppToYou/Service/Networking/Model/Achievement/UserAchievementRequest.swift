import Foundation


class UserAchievementRequest: Encodable {
    let achievementId: Int?
    let completionDate: String?
    let phoneId: Int?
    
    init(achievementId: Int? = nil, completionDate: String? = nil, phoneId: Int? = nil) {
        self.achievementId = achievementId
        self.completionDate = completionDate
        self.phoneId = phoneId
    }
}
