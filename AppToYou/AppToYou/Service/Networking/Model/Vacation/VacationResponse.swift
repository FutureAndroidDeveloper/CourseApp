import Foundation


class VacationResponse: Encodable {
    let id: Int?
    let userId: Int?
    let startDate: String?
    let endDate: String?
    let createdTimestamp: String?
    let updatedTimestamp: String?
    
    init(id: Int?, userId: Int?, startDate: String?, endDate: String?, createdTimestamp: String? = nil, updatedTimestamp: String? = nil) {
        self.id = id
        self.userId = userId
        self.startDate = startDate
        self.endDate = endDate
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
    }
}
