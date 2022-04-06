import Foundation
import RealmSwift


class RealmTaskResult: Object {
    @Persisted(primaryKey: true) var internalID: ObjectId
    @Persisted(originProperty: "taskResults") var belongsTask: LinkingObjects<Task>
    
    @Persisted var progress: TaskProgress = .notStarted
    @Persisted var date: String = Date().toString(dateFormat: .localDateTime)
    @Persisted var isComplete: Bool = false
    @Persisted var result: String?
}
