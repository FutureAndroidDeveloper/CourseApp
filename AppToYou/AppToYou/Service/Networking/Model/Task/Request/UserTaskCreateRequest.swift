import Foundation


class UserTaskCreateRequest: CreateTaskRequest {
    var startDate: String
    var endDate: String?
    var reminderList: [String]?
    
    init(
        taskName: String, taskType: TaskType, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, startDate: String,
        endDate: String? = nil, reminderList: [String]? = nil, daysCode: String? = nil,
        taskDescription: String? = nil, taskAttribute: String? = nil)
    {
        self.startDate = startDate
        self.endDate = endDate
        self.reminderList = reminderList
        super.init(taskName: taskName, taskType: taskType, frequencyType: frequencyType,
                   taskSanction: taskSanction, infiniteExecution: infiniteExecution,
                   daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case reminderList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        startDate = try container.decode(String.self, forKey: .startDate)
        endDate = try? container.decode(String.self, forKey: .endDate)
        reminderList = try? container.decode([String].self, forKey: .reminderList)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(startDate, forKey: .startDate)
        try? container.encode(endDate, forKey: .endDate)
        try? container.encode(reminderList, forKey: .reminderList)
        try super.encode(to: encoder)
    }
    
}


extension UserTaskCreateRequest {
    
    static var emptyUserTaskRequest: UserTaskCreateRequest {
        return .init(taskName: String(), taskType: .CHECKBOX, frequencyType: .EVERYDAY,
                     taskSanction: .zero, infiniteExecution: Bool(), startDate: String())
    }
    
}
