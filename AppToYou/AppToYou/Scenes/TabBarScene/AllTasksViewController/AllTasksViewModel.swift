import Foundation
import XCoordinator


protocol AllTasksViewModelInput: AnyObject {
    func edit(_ task: UserTaskResponse)
    func showMyTasks(_ state: Bool)
    func showTestSanction(for task: UserTaskResponse)
    func refresh()
}

protocol AllTasksViewModelOutput: AnyObject {
    var tasks: Observable<[UserTaskResponse]> { get set }
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
    
    var tasks: Observable<[UserTaskResponse]> = Observable([])
    
    private var receivedTasks: [UserTaskResponse] = []
    
    private let router: UnownedRouter<TasksRoute>
    private let tasksService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    

    init(router: UnownedRouter<TasksRoute>) {
        self.router = router
    }
    
    
    func refresh() {
        loadTasks()
    }
    
    func showTestSanction(for task: UserTaskResponse) {
        router.trigger(.showSanction(task: task))
    }
    
    func edit(_ task: UserTaskResponse) {
        if let _ = task.courseTaskId {
            router.trigger(.editCourseTask(task: task))
        } else {
            router.trigger(.editUserTask(task: task))
        }
    }
    
    func showMyTasks(_ state: Bool) {
        if state {
            let userId = UserSession.shared.getUser()?.id
            tasks.value = receivedTasks.filter { $0.userId == userId }
        } else {
            tasks.value = receivedTasks
        }
        
    }
    
    private func loadTasks() {
        tasksService.getTaskFullList { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.receivedTasks = tasks
                self?.tasks.value = tasks
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

