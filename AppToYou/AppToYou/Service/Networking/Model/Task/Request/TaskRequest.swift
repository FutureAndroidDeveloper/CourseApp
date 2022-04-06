import Foundation


class TaskRequest: Codable {
    var taskName: String
    var frequencyType: Frequency
    var infiniteExecution: Bool
    var taskSanction: Int

    var daysCode: String?
    var taskAttribute: String?
    var taskDescription: String?
    
    init(
        taskName: String, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, daysCode: String? = nil,
        taskDescription: String? = nil, taskAttribute: String? = nil)
    {
        self.taskName = taskName
        self.frequencyType = frequencyType
        self.taskSanction = taskSanction
        self.infiniteExecution = infiniteExecution
        self.daysCode = daysCode
        self.taskDescription = taskDescription
        self.taskAttribute = taskAttribute
    }
    
    private enum CodingKeys: String, CodingKey {
        case taskName
        case frequencyType
        case taskSanction
        case infiniteExecution
        case daysCode
        case taskDescription
        case taskAttribute
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        taskName = try container.decode(String.self, forKey: .taskName)
        frequencyType = try container.decode(Frequency.self, forKey: .frequencyType)
        infiniteExecution = try container.decode(Bool.self, forKey: .infiniteExecution)
        taskSanction = try container.decode(Int.self, forKey: .taskSanction)
        
        daysCode = try? container.decode(String.self, forKey: .daysCode)
        taskDescription = try? container.decode(String.self, forKey: .taskDescription)
        taskAttribute = try? container.decode(String.self, forKey: .taskAttribute)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(taskName, forKey: .taskName)
        try container.encode(frequencyType, forKey: .frequencyType)
        try container.encode(infiniteExecution, forKey: .infiniteExecution)
        try container.encode(taskSanction, forKey: .taskSanction)
        
        try? container.encode(daysCode, forKey: .daysCode)
        try? container.encode(taskDescription, forKey: .taskDescription)
        try? container.encode(taskAttribute, forKey: .taskAttribute)
    }
    
}

extension TaskRequest {
    static var emptyTaskRequest: TaskRequest {
        return .init(taskName: String(), frequencyType: .EVERYDAY, taskSanction: .zero, infiniteExecution: Bool())
    }
}
