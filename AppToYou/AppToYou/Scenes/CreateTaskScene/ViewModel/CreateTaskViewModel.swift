import Foundation
import XCoordinator



protocol CreateTaskViewModelInput {
    func updateTaskCreationModel()
    func notificationTimePicked(_ time: NotificationTime)
}

protocol CreateTaskViewModelOutput {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
}



protocol CreateTaskViewModel {
    var input: CreateTaskViewModelInput { get }
    var output: CreateTaskViewModelOutput { get }
}

extension CreateTaskViewModel where Self: CreateTaskViewModelInput & CreateTaskViewModelOutput {
    var input: CreateTaskViewModelInput { return self }
    var output: CreateTaskViewModelOutput { return self }
}


class CreateTaskViewModelImpl: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {

    private let router: UnownedRouter<TasksRoute>
    private let taskType: ATYTaskType
    
    private var taskModel: ATYUserTask!
    
    private lazy var constructor: Tester = {
        return Tester(type: self.taskType, delegate: self)
    }()
    
    private var notifModels: [NotificationTaskTimeModel] = []
    private var notificationView: NotificationTaskTimeView?
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())

    init(taskType: ATYTaskType, router: UnownedRouter<TasksRoute>) {
        self.taskType = taskType
        self.router = router
        update()
    }
    
    func updateTaskCreationModel() {
        
    }
    
    func notificationTimePicked(_ time: NotificationTime) {
        guard let notificationView = notificationView else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: time)
        notificationView.configure(with: model)
        
        notificationDelegate?.notificationDidAdd(notificationView)
        updateState()
    }
    
    
}

extension CreateTaskViewModelImpl: TesterDelegate {
    func showTimePicker(for notification: NotificationTaskTimeView, delegate: TaskNoticationDelegate) {
        notificationDelegate = delegate
        notificationView = notification
        router.trigger(.timePicker)
    }
    
    func getNotificationModels() -> [NotificationTaskTimeModel] {
        if notifModels.isEmpty {
            let model = NotificationTaskTimeModel(hourModel: NotificationTimeBlockModelFactory.getHourModel(),
                                                  minModel: NotificationTimeBlockModelFactory.getMinModel())
            notifModels.append(model)
        }
        return notifModels
    }
    
    func update() {
        data.value = constructor.getModel()
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
}


class TaskCreationBuilder {
    
    private var taskCellModel: [AnyObject]
    
    init(taskCellModel: [AnyObject] = []) {
        self.taskCellModel = taskCellModel
    }
    
    func createTaskNameCellModel(_ completion: @escaping (String) -> Void) -> Self {
        let model = CreateTaskNameCellModel(nameCallback: completion)
        taskCellModel.append(model)
        
        return self
    }
    
    func createTaskCountingCellModel(_ completion: @escaping (ATYFrequencyTypeEnum) -> Void) -> Self {
        let model = CreateTaskCountingCellModel(frequencyPicked: completion)
        taskCellModel.append(model)
        
        return self
    }
    
    
    func createTaskPeriodCalendarCellModel(_ startCompletion: @escaping DateCompletion, _ endCompletion: @escaping DateCompletion) -> Self {
        let model = CreateTaskPeriodCalendarCellModel(startPicked: startCompletion, endPicked: endCompletion)
        taskCellModel.append(model)
        
        return self
    }
}

