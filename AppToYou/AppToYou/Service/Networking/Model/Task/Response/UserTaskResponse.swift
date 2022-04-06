import Foundation


class UserTaskResponse: UserTaskCreateRequest {
    var identifier: TaskResponse
    var editableCourseTask: Bool
    
    var userId: Int?
    
    var courseTaskId: Int?
    var courseName: String?
    var minimumCourseTaskSanction: Int?
    
    var phoneId: Int?
    var taskCompleteTime: String?
    var taskResults: [TaskResult]?
    
    convenience init(createRequest: UserTaskCreateRequest, phoneId: Int) {
        let identifier = TaskResponse()
        self.init(
            identifier: identifier, editableCourseTask: false, taskName: createRequest.taskName, taskType: createRequest.taskType,
            frequencyType: createRequest.frequencyType, taskSanction: createRequest.taskSanction, infiniteExecution: createRequest.infiniteExecution,
            startDate: createRequest.startDate, endDate: createRequest.endDate, reminderList: createRequest.reminderList,
            daysCode: createRequest.daysCode, taskDescription: createRequest.taskDescription, taskAttribute: createRequest.taskAttribute, phoneId: phoneId
        )
    }
    
    init(
        identifier: TaskResponse, editableCourseTask: Bool, taskName: String, taskType: TaskType, frequencyType: Frequency,
        taskSanction: Int, infiniteExecution: Bool, startDate: String, endDate: String? = nil, reminderList: [String]? = nil,
        daysCode: String? = nil, taskDescription: String? = nil, taskAttribute: String? = nil, userId: Int? = nil,
        courseTaskId: Int? = nil, courseName: String? = nil, minimumCourseTaskSanction: Int? = nil, phoneId: Int? = nil,
        taskCompleteTime: String? = nil, taskResults: [TaskResult]? = nil)
    {
        self.identifier = identifier
        self.editableCourseTask = editableCourseTask
        self.userId = userId
        self.courseTaskId = courseTaskId
        self.courseName = courseName
        self.minimumCourseTaskSanction = minimumCourseTaskSanction
        self.phoneId = phoneId
        self.taskCompleteTime = taskCompleteTime
        self.taskResults = taskResults
        
        super.init(taskName: taskName, taskType: taskType, frequencyType: frequencyType, taskSanction: taskSanction, infiniteExecution: infiniteExecution, startDate: startDate, endDate: endDate, reminderList: reminderList, daysCode: daysCode, taskDescription: taskDescription, taskAttribute: taskAttribute)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case editableCourseTask
        case userId
        case courseTaskId
        case courseName
        case minimumCourseTaskSanction
        case phoneId
        case taskCompleteTime
        case taskResults
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try identifier.encode(to: encoder)
        
        try container.encode(editableCourseTask, forKey: .editableCourseTask)
        try? container.encode(userId, forKey: .userId)
        try? container.encode(courseTaskId, forKey: .courseTaskId)
        try? container.encode(courseName, forKey: .courseName)
        try? container.encode(minimumCourseTaskSanction, forKey: .minimumCourseTaskSanction)
        try? container.encode(phoneId, forKey: .phoneId)
        try? container.encode(taskCompleteTime, forKey: .taskCompleteTime)
        try? container.encode(taskResults, forKey: .taskResults)
        
//        encoder.container(keyedBy: <#T##CodingKey.Protocol#>)
//        
//        try? container.encode(identifier.updatedTimestamp, forKey: identifier.)

        try super.encode(to: encoder)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try TaskResponse(from: decoder)
        
        editableCourseTask = try container.decode(Bool.self, forKey: .editableCourseTask)
        userId = try? container.decode(Int.self, forKey: .userId)
        courseTaskId = try? container.decode(Int.self, forKey: .courseTaskId)
        courseName = try? container.decode(String.self, forKey: .courseName)
        minimumCourseTaskSanction = try? container.decode(Int.self, forKey: .minimumCourseTaskSanction)
        phoneId = try? container.decode(Int.self, forKey: .phoneId)
        taskCompleteTime = try? container.decode(String.self, forKey: .taskCompleteTime)
        taskResults = try? container.decode([TaskResult].self, forKey: .taskResults)
        
        try super.init(from: decoder)
    }
    
}
