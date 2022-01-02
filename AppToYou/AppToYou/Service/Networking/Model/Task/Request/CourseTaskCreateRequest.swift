import Foundation


class CourseTaskCreateRequest: CreateTaskRequest {
    var duration: Duration?
    var editable: Bool?
    var minSanction: Int?
    
    
    init(
        taskName: String, taskType: ATYTaskType, frequencyType: ATYFrequencyTypeEnum,
        taskSanction: Int, infiniteExecution: Bool, duration: Duration? = nil,
        editable: Bool? = nil, minSanction: Int? = nil, daysCode: String? = nil,
        taskDescription: String? = nil, taskAttribute: String? = nil)
    {
        self.duration = duration
        self.editable = editable
        self.minSanction = minSanction
        super.init(taskName: taskName, taskType: taskType, frequencyType: frequencyType,
                   taskSanction: taskSanction, infiniteExecution: infiniteExecution,
                   daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case duration
        case editable
        case minSanction
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        duration = try? container.decode(Duration.self, forKey: .duration)
        editable = try? container.decode(Bool.self, forKey: .editable)
        minSanction = try? container.decode(Int.self, forKey: .minSanction)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(duration, forKey: .duration)
        try? container.encode(editable, forKey: .editable)
        try? container.encode(minSanction, forKey: .minSanction)
        try super.encode(to: encoder)
    }
    
}


extension CourseTaskCreateRequest {
    static var emptyCourseTaskRequest: CourseTaskCreateRequest {
        return .init(taskName: String(), taskType: .CHECKBOX, frequencyType: .ONCE,
                     taskSanction: .zero, infiniteExecution: Bool())
    }
}
