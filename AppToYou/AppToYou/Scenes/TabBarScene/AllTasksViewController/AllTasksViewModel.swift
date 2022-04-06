import Foundation
import XCoordinator


protocol AllTasksViewModelInput: AnyObject {
    func edit(_ taskIndex: Int)
    func remove(_ taskIndex: Int)
    func showMyTasks(_ state: Bool)
    func refresh()
    func createTask()
}

protocol AllTasksViewModelOutput: AnyObject {
    var tasks: [TaskCellModel] { get set }
    var update: Observable<Void> { get set }
}

protocol AllTasksViewModel: AnyObject {
    var input: AllTasksViewModelInput { get }
    var output: AllTasksViewModelOutput { get }
}

extension AllTasksViewModel where Self: AllTasksViewModelInput & AllTasksViewModelOutput {
    var input: AllTasksViewModelInput { return self }
    var output: AllTasksViewModelOutput { return self }
}


class AllTasksViewModelImpl: AllTasksViewModel, AllTasksViewModelInput, AllTasksViewModelOutput {
    var tasks: [TaskCellModel] = []
    var update: Observable<Void> = Observable(Void())
    
    private let router: UnownedRouter<TasksRoute>
    private let synchronizationService: SynchronizationService
    private let infoProvider = TaskInfoProvider()
    private let database: Database = RealmDatabase()
    

    init(synchronizationService: SynchronizationService, router: UnownedRouter<TasksRoute>) {
        self.synchronizationService = synchronizationService
        self.router = router
        loadTasks()
    }
    
    func refresh() {
        loadTasks()
    }
    
    private func loadTasks() {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.setValue(1, for: .year)
        guard let futureDate = Calendar.current.date(byAdding: components, to: Date()) else {
            print("cant create date in future")
            return
        }
        
        tasks = database.getTasks()
            .filter { task in
                guard let endDate = task.endDate?.toDate(dateFormat: .localeYearDate) else {
                    return true
                }
                let result = calendar.compare(endDate, to: Date(), toGranularity: .day)
                return (result == .orderedSame || result == .orderedDescending)
            }
            .map { infoProvider.convert(task: $0, for: futureDate) }
        
        update.value = Void()
    }
    
    func edit(_ taskIndex: Int) {
        let task = tasks[taskIndex].task
        
        if let _ = task.courseTaskId {
            router.trigger(.editCourseTask(task: task))
        } else {
            router.trigger(.editUserTask(task: task))
        }
    }
    
    func remove(_ taskIndex: Int) {
        let task = tasks[taskIndex].task
        synchronizationService.remove(task: task)
        
        tasks.remove(at: taskIndex)
        update.value = Void()
    }
    
    func showMyTasks(_ state: Bool) {
        if state {
            tasks = tasks.filter { $0.task.courseTaskId == nil }
            update.value = Void()
        } else {
            loadTasks()
        }
    }
    
    func createTask() {
        router.trigger(.create)
    }
}

