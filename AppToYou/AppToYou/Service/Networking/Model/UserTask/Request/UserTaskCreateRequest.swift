import Foundation


class UserTaskCreateRequest: Codable {
    var taskName: String
    var taskType: ATYTaskType
    var frequencyType: ATYFrequencyTypeEnum
    var taskSanction: Int
    
    var infiniteExecution: Bool
    var startDate: String
    var endDate: String?
    
    var daysCode: String?
    var taskDescription: String?
    var reminderList: [String]?
    
    var taskAttribute: String?
    
    init(
        taskName: String, taskType: ATYTaskType, frequencyType: ATYFrequencyTypeEnum, taskSanction: Int,
        infiniteExecution: Bool, startDate: String, endDate: String? = nil, daysCode: String? = nil,
        taskDescription: String? = nil, reminderList: [String]? = nil, taskAttribute: String? = nil)
    {
        self.taskName = taskName
        self.taskType = taskType
        self.frequencyType = frequencyType
        self.taskSanction = taskSanction
        self.infiniteExecution = infiniteExecution
        self.startDate = startDate
        self.endDate = endDate
        self.daysCode = daysCode
        self.taskDescription = taskDescription
        self.reminderList = reminderList
        self.taskAttribute = taskAttribute
    }
    
    private enum CodingKeys: String, CodingKey {
        case taskName
        case taskType, frequencyType
        case taskSanction
        case infiniteExecution
        case startDate, endDate
        case daysCode
        case taskDescription
        case reminderList
        case taskAttribute
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(taskName, forKey: .taskName)
        try container.encode(taskType, forKey: .taskType)
        try container.encode(frequencyType, forKey: .frequencyType)
        try container.encode(infiniteExecution, forKey: .infiniteExecution)
        try container.encode(taskSanction, forKey: .taskSanction)
        try container.encode(startDate, forKey: .startDate)
        
        try? container.encode(daysCode, forKey: .daysCode)
        try? container.encode(taskDescription, forKey: .taskDescription)
        try? container.encode(endDate, forKey: .endDate)
        try? container.encode(reminderList, forKey: .reminderList)
        try? container.encode(taskAttribute, forKey: .taskAttribute)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        taskName = try container.decode(String.self, forKey: .taskName)
        taskType = try container.decode(ATYTaskType.self, forKey: .taskType)
        frequencyType = try container.decode(ATYFrequencyTypeEnum.self, forKey: .frequencyType)
        infiniteExecution = try container.decode(Bool.self, forKey: .infiniteExecution)
        taskSanction = try container.decode(Int.self, forKey: .taskSanction)
        startDate = try container.decode(String.self, forKey: .startDate)
        
        daysCode = try? container.decode(String.self, forKey: .daysCode)
        taskDescription = try? container.decode(String.self, forKey: .taskDescription)
        endDate = try? container.decode(String.self, forKey: .endDate)
        reminderList = try? container.decode([String].self, forKey: .reminderList)
        taskAttribute = try? container.decode(String.self, forKey: .taskAttribute)
    }
    
}
