import Foundation


protocol Database {
    func save(task: Task)
    
    func getTasks() -> [Task]
    func getTasks(for date: Date) -> [Task]
    
    func update(task: Task, state: TaskProgress, date: Date)
    func update(task: Task)
    
    func set(task: Task, id: Int?)
    func setSynchronized(task: Task, value: Bool)
    
    func remove(_ task: Task)
    func clearRemovedTasks()
    func getRemovedTasks() -> [RemovedTask]
    
    // Result
    func createResult(for task: Task, date: Date?)
    func update(result: RealmTaskResult, value: String?, isCompleted: Bool)
    func update(result: RealmTaskResult, progress: TaskProgress)
}
