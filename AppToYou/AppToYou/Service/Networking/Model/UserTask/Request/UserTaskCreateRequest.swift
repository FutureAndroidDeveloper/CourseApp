import Foundation


struct UserTaskCreateRequest: Codable {
    var taskName: String
    var taskType: ATYTaskType
    var frequencyType: ATYFrequencyTypeEnum
    var taskSanction: Int32
    
    var infiniteExecution: Bool
    var startDate: String
    var endDate: String?
    
    var daysCode: String?
    var taskDescription: String?
    var reminderList: [String]?
    
    // duration?
    var taskAttribute: String?
}
