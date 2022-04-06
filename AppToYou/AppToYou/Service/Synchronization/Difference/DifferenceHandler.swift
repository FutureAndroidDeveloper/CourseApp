import Foundation


/**
 Обработчик различий в базах данных.
 */
class DifferenceHandler: DatabaseDifferenceDelegate {
    private let database: Database
    private let taskService: TaskManager
    private let adapter: TaskAdapter
    
    private let taskUpdateHelper: TaskUpdateHelper
    
    private var newTasks = [Task]()
    private var editedTasks = [Task]()
    private var removedTaskIds = [Int]()
    
    private var tasksToUpdate: [Task] {
        return newTasks + editedTasks
    }
        
    init(database: Database = RealmDatabase(), deviceIdentifier: DeviceIdentifiable = DeviceIdentifierService()) {
        self.database = database
        self.taskService = TaskManager(deviceIdentifierService: deviceIdentifier)
        self.adapter = TaskAdapter()
        self.taskUpdateHelper = TaskUpdateHelper(database: database)
    }
    
    /**
     Сформировать запрос на обновление данных на сервере.
     */
    func buildUpdateRequest() -> UpdateInfoRequest {
        let removed = removedTaskIds.isEmpty ? nil : removedTaskIds
        let update = tasksToUpdate.compactMap { adapter.convert(task: $0, to: UserTaskResponse.self) }
        let taskList = update.isEmpty ? nil : update
        
        let request = UpdateInfoRequest(
            removedUserTaskIdList: removed, sanctionList: nil,
            statistics: nil, transactionList: nil,
            userAchievementList: nil, userTaskList: taskList,
            vacationList: nil
        )
        
        return request
    }
    
    /**
     Обработать обновленные данные с сервера.
     */
    func handle(updated value: UpdateInfoResponse) {
        let syncedTasks = (value.userTaskResponseList ?? []).compactMap { adapter.convert(userTaskResponse: $0) }
        
        syncedTasks.forEach { task in
            guard
                let localTask = tasksToUpdate.first(where: { task.id == $0.id || task.phoneId == $0.phoneId })
            else {
                print("cant find local task for updating")
                return
            }
            taskUpdateHelper.update(localTask: localTask, serverTask: task)
        }
        
        database.clearRemovedTasks()
    }
    
    /**
     Сбросить настройки разницы данных.
     */
    func reset() {
        newTasks.removeAll()
        editedTasks.removeAll()
        removedTaskIds.removeAll()
    }
    
    func localTaskDidAdd(_ task: Task) {
        newTasks.append(task)
    }
    
    func localTaskDidEdit(_ task: Task) {
        editedTasks.append(task)
    }
    
    func localTaskDidRemove(id: Int) {
        removedTaskIds.append(id)
    }
    
    func serverTasksDidAdd(_ task: Task) {
        taskUpdateHelper.save(serverTask: task)
    }
    
    func serverTaskDidEdit(local: Task, server: Task) {
        editedTasks.removeAll {
            guard let id = $0.id else {
                return false
            }
            return id == server.id
        }
        
        guard let id = server.id, !removedTaskIds.contains(id) else {
            return
        }
        
        taskUpdateHelper.update(localTask: local, serverTask: server)
    }
    
    func serverTaskDidRemove(_ task: Task) {
        editedTasks.removeAll {
            guard let id = $0.id else {
                return false
            }
            return id == task.id
        }
        
        removedTaskIds.removeAll { $0 == task.id }
        database.remove(task)
    }
    
}
