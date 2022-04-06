import Foundation


class CreateTaskRequest: TaskRequest {
    var taskType: TaskType
    
    init(
        taskName: String, taskType: TaskType, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, daysCode: String? = nil,
        taskDescription: String? = nil, taskAttribute: String? = nil)
    {
        self.taskType = taskType
        super.init(
            taskName: taskName, frequencyType: frequencyType, taskSanction: taskSanction, infiniteExecution: infiniteExecution,
            daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case taskType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        taskType = try container.decode(TaskType.self, forKey: .taskType)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(taskType, forKey: .taskType)
        try super.encode(to: encoder)
    }
    
}
