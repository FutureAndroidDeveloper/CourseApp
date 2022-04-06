import Foundation


/**
 Отвечает за обновление и сохраниение новых задач.
 */
class TaskUpdateHelper {
    private let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func update(localTask: Task, serverTask: Task) {
        guard !localTask.isInvalidated, !serverTask.isInvalidated else {
            return
        }
        
        serverTask.internalID = localTask.internalID
        serverTask.phoneId = nil
        
        syncResults(locaL: localTask, server: serverTask)
        database.update(task: serverTask)
        database.setSynchronized(task: serverTask, value: true)
    }
    
    func save(serverTask: Task) {
        guard !serverTask.isInvalidated else {
            return
        }
        
        serverTask.phoneId = nil
        serverTask.taskResults.forEach {
            $0.progress = getResultProgress(task: serverTask, result: $0)
        }
        
        database.save(task: serverTask)
        database.setSynchronized(task: serverTask, value: true)
    }
    
    /**
     Обновление и добавление данных с сервера в локальные результаты выполнения задачи.
     */
    private func syncResults(locaL: Task, server: Task) {
        let localResults = locaL.taskResults
        let serverResults = server.taskResults
        
        serverResults.forEach { serverResult in
            let existingResult = localResults.first { localResult in
                guard
                    let localDate = localResult.date.toDate(dateFormat: .localDateTime),
                    let serverDate = serverResult.date.toDate(dateFormat: .localDateTime)
                else {
                    return false
                }
                return Calendar.current.compare(localDate, to: serverDate, toGranularity: .day) == .orderedSame
            }
            
            if let result = existingResult {
                serverResult.internalID = result.internalID
                serverResult.progress = result.progress
            } else {
                serverResult.progress = getResultProgress(task: server, result: serverResult)
            }
        }
    }
    
    /**
      Возвращает прогресс выполенения задачи.
     
      Необходимо установить прогресс задачи после получения результатов с сервера.
     */
    private func getResultProgress(task: Task, result: RealmTaskResult) -> TaskProgress {
        let today = Date()
        
        guard let resultDate = result.date.toDate(dateFormat: .localDateTime) else {
            print("cant convert result date")
            return .notStarted
        }
        
        switch (task.taskType, result.isComplete) {
        case (.CHECKBOX, true):
            return .done
            
        case (.CHECKBOX, false):
            if Calendar.current.compare(today, to: resultDate, toGranularity: .day) == .orderedDescending {
                return .failed
            } else {
                return .notStarted
            }
            
        case (.TEXT, true):
            return .done
            
        case (.TEXT, false):
            if Calendar.current.compare(today, to: resultDate, toGranularity: .day) == .orderedDescending {
                return .failed
            } else {
                return task.taskAttribute == nil ? .notStarted : .inProgress
            }
            
        case (.TIMER, true):
            return .done
            
        case (.TIMER, false):
            if Calendar.current.compare(today, to: resultDate, toGranularity: .day) == .orderedDescending {
                return .failed
            } else {
                return .notStarted
            }
            
        case (.RITUAL, true):
            return .done
            
        case (.RITUAL, false):
            if Calendar.current.compare(today, to: resultDate, toGranularity: .day) == .orderedDescending {
                return .failed
            } else {
                return task.taskAttribute == nil ? .notStarted : .inProgress
            }
        }
    }
    
}
