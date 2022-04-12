import Foundation


/**
 Сервис синхронизации данных между приложением и сервером.
 */
class SynchronizationService: TaskResultHelperDelegate {
    let minSyncAlertDuration: Double = 2
    let resultAlertDuration: Double = 1
    
    let resultHelper = TaskResultHelper()
    
    private var delegates = SynchronizationMulticastDelegate()
    
    private let idGenerator: PhoneTaskIdGenerating
    private let taskService: TaskManager
    private let userService: UserManager
    private let database: Database
    
    private let difference: DifferenceManager
    private let diffHandler: DifferenceHandler
    
    private var startTime = DispatchTime.now()
    private var endTime = DispatchTime.now()
    private var today: Date {
        return Date()
    }
    
    init(
        idGenerator: PhoneTaskIdGenerating = TaskPhoneIdGenerator(),
        deviceIdentifier: DeviceIdentifiable = DeviceIdentifierService(),
        database: Database = RealmDatabase()
    ) {
        
        self.idGenerator = idGenerator
        self.userService = UserManager(deviceIdentifierService: deviceIdentifier)
        self.taskService = TaskManager(deviceIdentifierService: deviceIdentifier)
        self.diffHandler = DifferenceHandler(database: database, deviceIdentifier: deviceIdentifier)
        self.database = database
        
        self.difference = DifferenceManager(database: database, deviceIdentifier: deviceIdentifier)
        difference.delegate = diffHandler
        
        resultHelper.delegate = self
    }
    
    func addHandler(_ delegate: SynchronizationDelegate) {
        delegates.add(delegate)
    }
    
    func synchronize() {
        delegates.synchronizationDidStart()
        startTime = .now()
        
        difference.findDifference { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success:
                let request = self.diffHandler.buildUpdateRequest()
                self.userService.updateInfo(request) { [weak self] result in
                    switch result {
                    case .success(let response):
                        self?.diffHandler.handle(updated: response)
                        self?.endTime = .now()
                        self?.finishNotification()
                        
                    case .failure(let error):
                        print(error)
                        self?.errorNotification(error)
                    }
                }
                
            case .failure(let error):
                self.errorNotification(error)
            }
        }
    }
    
    func validateResults() {
        database.getTasks().forEach { resultHelper.validateResult(for: $0) }
    }
    
    func create(task: Task) {
        guard !task.isInvalidated else {
            return
        }
        
        // создать задачу в локальной базе данных
        task.phoneId = idGenerator.genarateId()
        database.save(task: task)
        if resultHelper.isTask(task, belongs: today) {
            database.createResult(for: task, date: nil)
        }
        
        guard let request = createTaskRequest(task: task, request: UserTaskCreateRequest.self) else {
            print("cant create `UserTaskCreateRequest` for task `\(task.taskName)`")
            return
        }
        // создание задачи на сервере
        taskService.create(task: request) { [weak self] result in
            switch result {
            case .success(let newTask):
                print(newTask)
                self?.database.set(task: task, id: newTask.identifier.id)
                self?.database.setSynchronized(task: task, value: true)
                
            case .failure(let error):
                print(error)
                self?.database.setSynchronized(task: task, value: false)
            }
        }
    }
    
    func update(task: Task) {
        guard !task.isInvalidated else {
            return
        }
        database.update(task: task)
        
        guard let updatedTask = createTaskRequest(task: task, request: UserTaskResponse.self) else {
            print("cant create `UserTaskUpdateRequest` for task `\(task.taskName)`")
            return
        }
        let request = UpdateInfoRequest(
            removedUserTaskIdList: nil, sanctionList: nil, statistics: nil, transactionList: nil,
            userAchievementList: nil, userTaskList: [updatedTask], vacationList: nil
        )
        
        userService.updateInfo(request) { [weak self] result in
            switch result {
            case .success(let response):
                guard
                    let serverTask = response.userTaskResponseList?.first,
                    serverTask.identifier.id == task.id
                else {
                    self?.database.setSynchronized(task: task, value: false)
                    return
                }
                self?.database.setSynchronized(task: task, value: true)
                print(response)
                
            case .failure(let error):
                print(error)
                self?.database.setSynchronized(task: task, value: false)
            }
        }
    }
    
    func remove(task: Task) {
        guard !task.isInvalidated else {
            return
        }
        
        let removedId = task.id
        database.remove(task)
        
        guard let id = removedId else {
            print("delete request will not be executed for a local task")
            return
        }

        taskService.remove(taskId: id) { _ in
            return
        }
    }
    
    func isCourseTaskExist(_ task: CourseTaskResponse) -> Bool {
        return database.isCourseTaskExist(task)
    }
    
    // MARK: TaskResultHelperDelegate
    
    func didFindTaskWithoutResult(_ task: Task, for date: Date) {
        guard !task.isInvalidated else {
            return
        }
        database.createResult(for: task, date: date)
    }
    
    func didFindUncompletedTaskResult(_ result: RealmTaskResult, newProgress: TaskProgress) {
        guard !result.isInvalidated else {
            return
        }
        database.update(result: result, progress: newProgress)
    }
    
    private func finishNotification() {
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let duration = Double(nanoTime) / 1_000_000_000
        let syncDuration = max(0, minSyncAlertDuration - duration)
        delegates.synchronizationDidFinish(result: .success(syncDuration))
    }
    
    private func errorNotification(_ error: Error) {
        delegates.synchronizationDidFinish(result: .failure(error))
    }
    
    private func createTaskRequest<Request: Decodable>(task: Task, request: Request.Type) -> Request? {
        guard
            let taskData = try? JSONSerialization.data(withJSONObject: task.toDictionary(), options: []),
            let taskRequest = try? JSONDecoder().decode(request, from: taskData)
        else {
            return nil
        }
        return taskRequest
    }
    
}
