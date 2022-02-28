import Foundation
import XCoordinator


protocol TodayTasksViewModelInput: AnyObject {
    func addTask()
    func refresh()
    
    func startTimer(for model: NewTaskCellModel)
}

protocol TodayTasksViewModelOutput: AnyObject {
    
    var models: Observable<[NewTaskCellModel]> { get set }
    
    var tasks: Observable<[UserTaskResponse]> { get set }
    var completedTasks: Observable<[UserTaskResponse]> { get set }
    var tasksInProgress: Observable<[UserTaskResponse]> { get set }
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
    
    
    var models: Observable<[NewTaskCellModel]> = Observable([])
    
    var tasks: Observable<[UserTaskResponse]> = Observable([])
    
    var completedTasks: Observable<[UserTaskResponse]> = Observable([])
    var tasksInProgress: Observable<[UserTaskResponse]> = Observable([])
    
    private var receivedTasks: [UserTaskResponse] = []
    
//    private var taskModels: [NewTaskCellModel] = []
    
    private let router: UnownedRouter<TasksRoute>
    private let tasksService = TaskManager(deviceIdentifierService: DeviceIdentifierService())
    private let timer = TaskTimer()
    
    
    init(router: UnownedRouter<TasksRoute>) {
        self.router = router
    }
    
    func refresh() {
        tasksService.getTaskFullList { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.tasks.value = tasks
                self?.configureModels()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addTask() {
        router.trigger(.create)
    }
    
    private func configureModels() {
        let infoProvider = TaskInfoProvider()
        models.value = tasks.value.map { infoProvider.convert(task: $0, for: Date()) }
    }
    
    func startTimer(for model: NewTaskCellModel) {
        if let timerActionModel = model.taskActionModel as? TaskTimerActionModel {
            timer.subscribe(timerActionModel.timerModel)
        }
    }
}

