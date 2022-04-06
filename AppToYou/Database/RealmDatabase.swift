import Foundation
import RealmSwift


enum RealmError: Error {
    case invalidatedObject
}


class RealmDatabase: Database {
    
    private let realm: Realm
        
    init() {
        realm = try! Realm()
    }
    
    // MARK: - Task
    
    func save(task: Task) {
        do {
            try safeWrite(objects: task) {
                realm.add(task)
            }
        } catch {
            print(error)
        }
        
    }
    
    func getTasks() -> [Task] {
        let tasks = realm.objects(Task.self)
        
        return Array(tasks)
    }
    
    func getTasks(for date: Date) -> [Task] {
        let tasks = realm.objects(Task.self).where {
            $0.taskResults.date.starts(with: date.toString(dateFormat: .localeYearDate))
        }
        
        return Array(tasks)
    }
    
    func update(task: Task, state: TaskProgress, date: Date) {
        let result = getResult(of: task, for: date)
        
        do {
            try safeWrite(objects: task) {
                if state == .done {
                    result?.isComplete = true
                }
                result?.progress = state
            }
        } catch {
            print(error)
        }
    }
    
    func update(task: Task) {
        do {
            try safeWrite(objects: task) {
                task.updatedTimestamp = Date().toString(dateFormat: .fullTime)
                realm.add(task, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func set(task: Task, id: Int?) {
        do {
            try safeWrite(objects: task) {
                task.phoneId = nil
                task.id = id
            }
        } catch {
            print(error)
        }
    }
    
    func setSynchronized(task: Task, value: Bool) {
        do {
            try safeWrite(objects: task) {
                task.isSynchronized = value
            }
        } catch {
            print(error)
        }
    }
    
    func remove(_ task: Task) {
        let removedId = task.id
        
        do {
            try safeWrite(objects: task) {
                realm.delete(task)
            }
            
            guard let id = removedId else {
                print("the deleted task will not be added to the list of deleted tasks, because missing task ID")
                return
            }
            let removedTask = RemovedTask()
            removedTask.id = id
            
            try safeWrite(objects: removedTask) {
                realm.add(removedTask)
            }
        } catch {
            print(error)
        }
        
    }
    
    func clearRemovedTasks() {
        do {
            try realm.write {
                let removedTasks = realm.objects(RemovedTask.self)
                realm.delete(removedTasks)
            }
        } catch {
            print(error)
        }
    }
    
    func getRemovedTasks() -> [RemovedTask] {
        let removedTasks = realm.objects(RemovedTask.self)
        return Array(removedTasks)
    }
    
    // MARK: - Result
    
    /**
     Дата для создания результатов в прошлом (если день пропущен установить проваленный прогресс)
     */
    func createResult(for task: Task, date: Date? = nil) {
        let result = RealmTaskResult()
        
        if let date = date {
            result.date = date.toString(dateFormat: .localDateTime)
            result.progress = .failed
        }
        
        do {
            try safeWrite(objects: task) {
                task.isSynchronized = false
                task.taskResults.append(result)
            }
        } catch {
            print(error)
        }
    }
    
    func update(result: RealmTaskResult, value: String?, isCompleted: Bool) {
        do {
            try safeWrite(objects: result) {
                result.belongsTask.first?.isSynchronized = false
                result.isComplete = isCompleted
                result.result = value
            }
        } catch {
            print(error)
        }
    }
    
    func update(result: RealmTaskResult, progress: TaskProgress) {
        do {
            try safeWrite(objects: result) {
                result.progress = progress
            }
        } catch {
            print(error)
        }
    }
    
    private func getResult(of task: Task, for date: Date) -> RealmTaskResult? {
        guard !task.isInvalidated else {
            return nil
        }
        return task.taskResults.first {
            return $0.date.starts(with: date.toString(dateFormat: .localeYearDate))
            
        }
    }
    
    private func safeWrite(objects: Object..., block: (() throws -> Void)) throws {
        guard objects.allSatisfy( { !$0.isInvalidated } ) else {
            print("the object for interacting with the database is invalidated")
            throw RealmError.invalidatedObject
        }
        
        try realm.write(block)
    }
}
