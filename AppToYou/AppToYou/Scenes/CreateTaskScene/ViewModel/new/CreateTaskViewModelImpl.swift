import Foundation
import XCoordinator


class CreateTaskViewModelImpl: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {

    private let router: UnownedRouter<TasksRoute>
    private let taskType: ATYTaskType
    private var taskModel: ATYUserTask!
    
    private lazy var constructor: TaskCreationModel = {
        return TaskCreationModel(type: self.taskType, delegate: self)
    }()
    
    private var notificationModels: [NotificationTaskTimeModel] = []
    private weak var notificationDelegate: TaskNoticationDelegate?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    

    init(taskType: ATYTaskType, router: UnownedRouter<TasksRoute>) {
        self.taskType = taskType
        self.router = router
        update()
    }
    
    func notificationTimePicked(_ time: NotificationTime) {
        guard let notificationDelegate = notificationDelegate else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: time)
        notificationDelegate.notificationDidAdd(model)
        notificationModels = notificationDelegate.getNotificationModels()
        updateState()
    }
    
}


extension CreateTaskViewModelImpl: TaskCreationDelegate {
    
    func showTimePicker(delegate: TaskNoticationDelegate) {
        notificationDelegate = delegate
        router.trigger(.timePicker)
    }
    
    func getNameModel() -> TextFieldModel {
        // TODO: - получать имя из модели задачи
        return .init(value: String(), placeholder: R.string.localizable.forExampleDoExercises())
    }
    
    func getNotificationModels() -> [NotificationTaskTimeModel] {
        if notificationModels.isEmpty {
            let model = NotificationTaskTimeModel(hourModel: NotificationTimeBlockModelFactory.getHourModel(),
                                                  minModel: NotificationTimeBlockModelFactory.getMinModel())
            notificationModels.append(model)
        }
        return notificationModels
    }
    
    func getWeekdayModels() -> [WeekdayModel] {
        // TODO: - получать модели из модели задачи или создавать новые из календаря
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        return orderedSymbols.map { WeekdayModel(title: $0) }
    }
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        data.value = constructor.getModel()
    }
    
    /**
     Обновление внутри ячеек.
     
     Приводит к вызову tableView.beginUpdates()
     */
    func updateState() {
        updatedState.value = ()
    }
    
}
