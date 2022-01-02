import Foundation


//class TaskResponse: CreateTaskRequest {
//    var id: Int
//    var createdTimestamp: String
//    var updatedTimestamp: String?
//
//    init(
//        taskName: String, taskType: ATYTaskType, frequencyType: ATYFrequencyTypeEnum,
//        taskSanction: Int, infiniteExecution: Bool, id: Int, createdTimestamp: String,
//        updatedTimestamp: String? = nil, daysCode: String? = nil,
//        taskDescription: String? = nil, taskAttribute: String? = nil)
//    {
//        self.id = id
//        self.createdTimestamp = createdTimestamp
//        self.updatedTimestamp = updatedTimestamp
//        super.init(taskName: taskName, taskType: taskType, frequencyType: frequencyType,
//                   taskSanction: taskSanction, infiniteExecution: infiniteExecution,
//                   daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case createdTimestamp
//        case updatedTimestamp
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(Int.self, forKey: .id)
//        createdTimestamp = try container.decode(String.self, forKey: .createdTimestamp)
//        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
//        try super.init(from: decoder)
//    }
//
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(id, forKey: .id)
//        try container.encode(createdTimestamp, forKey: .createdTimestamp)
//        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
//        try super.encode(to: encoder)
//    }
//}


class TaskResponse: Codable {
    var id: Int
    var createdTimestamp: String
    var updatedTimestamp: String?
    
    init(id: Int, createdTimestamp: String, updatedTimestamp: String? = nil) {
        self.id = id
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdTimestamp
        case updatedTimestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        createdTimestamp = try container.decode(String.self, forKey: .createdTimestamp)
        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(createdTimestamp, forKey: .createdTimestamp)
        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
    }
}
