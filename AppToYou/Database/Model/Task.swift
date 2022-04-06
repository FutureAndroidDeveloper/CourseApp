import Foundation
import RealmSwift


class Task: Object {
    @Persisted(primaryKey: true) var internalID: ObjectId
    @Persisted var isSynchronized: Bool = false
    
    @Persisted var phoneId: Int?
    
    @Persisted var createdTimestamp: String?
    @Persisted var editableCourseTask: Bool
    
    @Persisted var taskName: String
    @Persisted var taskType: TaskType
    @Persisted var frequencyType: Frequency
    @Persisted var startDate: String
    
    @Persisted var taskSanction: Int
    @Persisted var infiniteExecution: Bool
    
    @Persisted var id: Int?
    @Persisted var userId: Int?
    @Persisted var updatedTimestamp: String?
    
    @Persisted var endDate: String?
    @Persisted var reminderList: List<String>
    
    @Persisted var courseTaskId: Int?
    @Persisted var courseName: String?
    @Persisted var minimumCourseTaskSanction: Int?
    
    @Persisted var taskCompleteTime: String?
    @Persisted var taskResults: List<RealmTaskResult>
    
    @Persisted var taskDescription: String?
    @Persisted var daysCode: String?
    @Persisted var taskAttribute: String?
}
