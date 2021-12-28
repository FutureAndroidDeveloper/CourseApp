import Foundation


class UserTaskResponse: UserTaskCreateRequest {
    var editableCourseTask: Bool
    var createdTimestamp: String
    var updatedTimestamp: String?
    
    var taskCompleteTime: String?
    var taskResults: [TaskResult]?
    
    var id: Int
    var userId: Int
    var phoneId: Int
    
    var courseTaskId: Int?
    var courseName: String?
    var minimumCourseTaskSanction: Int
    
    init(
        taskRequest: UserTaskCreateRequest, editableCourseTask: Bool, createdTimestamp: String, updatedTimestamp: String? = nil,
        taskCompleteTime: String? = nil, taskResults: [TaskResult]? = nil, id: Int, userId: Int, phoneId: Int,
        courseTaskId: Int? = nil, courseName: String? = nil, minimumCourseTaskSanction: Int)
    {
        
        self.editableCourseTask = editableCourseTask
        self.createdTimestamp = createdTimestamp
        self.updatedTimestamp = updatedTimestamp
        self.taskCompleteTime = taskCompleteTime
        self.taskResults = taskResults
        self.id = id
        self.userId = userId
        self.phoneId = phoneId
        self.courseTaskId = courseTaskId
        self.courseName = courseName
        self.minimumCourseTaskSanction = minimumCourseTaskSanction
        
        let task = taskRequest
        super.init(
            taskName: task.taskName, taskType: task.taskType, frequencyType: task.frequencyType, taskSanction: task.taskSanction,
            infiniteExecution: task.infiniteExecution, startDate: task.startDate, endDate: task.endDate, daysCode: task.daysCode,
            taskDescription: task.taskDescription, reminderList: task.reminderList, taskAttribute: task.taskAttribute)
    }
    
    private enum CodingKeys: String, CodingKey {
        case editableCourseTask
        case createdTimestamp, updatedTimestamp
        case taskCompleteTime
        case taskResults
        case id, userId, phoneId, courseTaskId
        case courseName
        case minimumCourseTaskSanction
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(phoneId, forKey: .phoneId)
        
        try container.encode(minimumCourseTaskSanction, forKey: .minimumCourseTaskSanction)
        try container.encode(editableCourseTask, forKey: .editableCourseTask)
        try container.encode(createdTimestamp, forKey: .createdTimestamp)
        
        try? container.encode(updatedTimestamp, forKey: .updatedTimestamp)
        try? container.encode(courseTaskId, forKey: .courseTaskId)
        try? container.encode(courseName, forKey: .courseName)
        try? container.encode(taskCompleteTime, forKey: .taskCompleteTime)
        try? container.encode(taskResults, forKey: .taskResults)

        try super.encode(to: encoder)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        phoneId = try container.decode(Int.self, forKey: .phoneId)
        
        minimumCourseTaskSanction = try container.decode(Int.self, forKey: .minimumCourseTaskSanction)
        editableCourseTask = try container.decode(Bool.self, forKey: .editableCourseTask)
        createdTimestamp = try container.decode(String.self, forKey: .createdTimestamp)
        
        updatedTimestamp = try? container.decode(String.self, forKey: .updatedTimestamp)
        courseTaskId = try? container.decode(Int.self, forKey: .courseTaskId)
        courseName = try? container.decode(String.self, forKey: .courseName)
        taskCompleteTime = try? container.decode(String.self, forKey: .taskCompleteTime)
        taskResults = try? container.decode([TaskResult].self, forKey: .taskResults)
        
        try super.init(from: decoder)
    }
    
}
