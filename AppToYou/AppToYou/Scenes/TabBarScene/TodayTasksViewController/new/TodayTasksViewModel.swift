import Foundation
import XCoordinator


protocol TodayTasksViewModelInput: AnyObject {
    func addTask()
    func refresh()
}

protocol TodayTasksViewModelOutput: AnyObject {
    var tasks: Observable<[UserTaskResponse]> { get set }
}

protocol TodayTasksViewModel: AnyObject {
    var input: TodayTasksViewModelInput { get }
    var output: TodayTasksViewModelOutput { get }
}

extension TodayTasksViewModel where Self: TodayTasksViewModelInput & TodayTasksViewModelOutput {
    var input: TodayTasksViewModelInput { return self }
    var output: TodayTasksViewModelOutput { return self }
}


class TodayTasksViewModelImpl: TodayTasksViewModel, TodayTasksViewModelInput, TodayTasksViewModelOutput {
    
    var tasks: Observable<[UserTaskResponse]> = Observable([])
    
    private var receivedTasks: [UserTaskResponse] = []
    
    private let router: UnownedRouter<TasksRoute>
    private let tasksService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    

    init(router: UnownedRouter<TasksRoute>) {
        self.router = router
    }
    
    func refresh() {
        
    }
    
    func addTask() {
        router.trigger(.create)
    }
    
    
}

