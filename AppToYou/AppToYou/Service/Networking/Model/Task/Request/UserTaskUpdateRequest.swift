import Foundation


class UserTaskUpdateRequest: UserTaskCreateRequest {
    var id: Int?
    
    init(
        id: Int?, taskType: TaskType, taskName: String, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, startDate: String, endDate: String? = nil,
        reminderList: [String]? = nil, daysCode: String? = nil, taskDescription: String? = nil,
        taskAttribute: String? = nil)
    {
        self.id = id
        super.init(
            taskName: taskName, taskType: taskType, frequencyType: frequencyType, taskSanction: taskSanction,
            infiniteExecution: infiniteExecution, startDate: startDate, endDate: endDate, reminderList: reminderList,
            daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(id, forKey: .id)
        try super.encode(to: encoder)
    }
    
}
