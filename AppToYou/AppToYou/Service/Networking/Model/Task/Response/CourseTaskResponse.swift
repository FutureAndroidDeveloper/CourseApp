import Foundation


class CourseTaskResponse: CourseTaskCreateRequest {
    var identifier: TaskResponse
    var courseId: Int
    var materials: String?
    
    init(
        identifier: TaskResponse, courseId: Int, taskName: String, taskType: TaskType, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, duration: Duration? = nil, editable: Bool? = nil, minSanction: Int? = nil,
        daysCode: String? = nil, taskDescription: String? = nil, taskAttribute: String? = nil, materials: String? = nil)
    {
        self.identifier = identifier
        self.courseId = courseId
        self.materials = materials
        super.init(
            taskName: taskName, taskType: taskType, frequencyType: frequencyType, taskSanction: taskSanction,
            infiniteExecution: infiniteExecution, duration: duration, editable: editable, minSanction: minSanction,
            daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    

    private enum CodingKeys: String, CodingKey {
        case courseId
        case materials
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try TaskResponse(from: decoder)
        
        courseId = try container.decode(Int.self, forKey: .courseId)
        materials = try? container.decode(String.self, forKey: .materials)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try identifier.encode(to: encoder)
        
        try container.encode(courseId, forKey: .courseId)
        try? container.encode(materials, forKey: .materials)
        try super.encode(to: encoder)
    }
    
}
