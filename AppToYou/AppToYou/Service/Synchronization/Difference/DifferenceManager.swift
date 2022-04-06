import Foundation


/**
 Класс, отвечающий за поиск отличий в данных между базами данных сервера и приложения.
 */
class DifferenceManager {
    weak var delegate: DatabaseDifferenceDelegate?
    
    private let database: Database
    private let taskService: TaskManager
    private let adapter: TaskAdapter
    
    
    init(database: Database = RealmDatabase(), deviceIdentifier: DeviceIdentifiable = DeviceIdentifierService()) {
        self.database = database
        self.taskService = TaskManager(deviceIdentifierService: deviceIdentifier)
        self.adapter = TaskAdapter()
    }
    
    func findDifference(_ completion: @escaping (Result<Void, Error>) -> Void) {
        delegate?.reset()
        
        let localTasks = database.getTasks()
        let notSyncTasks = localTasks.filter { !$0.isSynchronized }
        
        findLocalCreatedTasks(notSyncTasks)
        findLocalEditedTasks(notSyncTasks)
        findLocalRemovedTasks()
        
        taskService.getTaskFullList { [weak self] result in
            switch result {
            case .success(let response):
                let serverTasks = response.compactMap { self?.adapter.convert(userTaskResponse: $0) }
                self?.findServerCreatedTasks(local: localTasks, server: serverTasks)
                self?.findSeverRemovedTasks(local: localTasks, server: serverTasks)
                self?.findServerEditedTasks(local: localTasks, server: serverTasks)
                completion(.success(Void()))
                
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        
    }
    
    // MARK: Local
    
    private func findLocalCreatedTasks(_ tasks: [Task]) {
        tasks
            .filter { $0.phoneId != nil }
            .forEach { delegate?.localTaskDidAdd($0) }
    }
    
    private func findLocalEditedTasks(_ tasks: [Task]) {
        tasks
            .filter { $0.id != nil }
            .forEach { delegate?.localTaskDidEdit($0) }
    }
    
    private func findLocalRemovedTasks() {
        database.getRemovedTasks()
            .forEach { delegate?.localTaskDidRemove(id: $0.id) }
    }
    
    // MARK: Server
    
    private func findServerCreatedTasks(local: [Task], server: [Task]) {
        server
            .filter { serverTask in
                !local.contains { $0.id == serverTask.id }
            }
            .forEach { self.delegate?.serverTasksDidAdd($0) }
    }
    
    private func findServerEditedTasks(local: [Task], server: [Task]) {
        server.forEach { serverTask in
            guard
                let localTask = local.first(where: { serverTask.id == $0.id }),
                let localDate = localTask.updatedTimestamp?.toDate(dateFormat: .fullTime),
                let serverDate = serverTask.updatedTimestamp?.toDate(dateFormat: .fullTime)
            else {
                return
            }
            
            if localDate < serverDate {
                delegate?.serverTaskDidEdit(local: localTask, server: serverTask)
            }
        }
    }
    
    private func findSeverRemovedTasks(local: [Task], server: [Task]) {
        local
            .filter { $0.id != nil }
            .filter { localTask in
                !server.contains { $0.id == localTask.id }
            }
            .forEach { self.delegate?.serverTaskDidRemove($0) }
    }
    
}
