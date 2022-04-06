import Foundation
import XCoordinator


class TodayTasksViewModelImpl: TodayTasksViewModel, TodayTasksViewModelInput, TodayTasksViewModelOutput {
    var inProgress: [TaskCellModel] = []
    var completed: [TaskCellModel] = []
    
    var update: Observable<Void> = Observable(Void())
    var refreshDate: Observable<Void> = Observable(Void())
    var insertUpdate: Observable<IndexPath> = Observable(.empty)
    var removeUpdate: Observable<IndexPath> = Observable(.empty)
    var reloadUpdate: Observable<IndexPath> = Observable(.empty)
    var dateIsOver: Observable<Void> = Observable(Void())
    
    private let router: UnownedRouter<TasksRoute>
    private let synchronizationService: SynchronizationService
    
    private let timerService = TaskTimerService()
    private let database: Database = RealmDatabase()
    private let infoProvider = TaskInfoProvider()
    
    
    private var dateEndTimer: Timer?
    private var lastSelectedDate: Date?
    
    
    init(synchronizationService: SynchronizationService, router: UnownedRouter<TasksRoute>) {
        self.synchronizationService = synchronizationService
        self.router = router
        infoProvider.modelDelegate = self
        infoProvider.actionDelegate = self
        infoProvider.progressActionDelegate = self
        
        setEndDayHandler()
    }
    
    func getTaskHintState() -> Bool {
        return !database.getTasks().isEmpty
    }
    
    private func setEndDayHandler() {
        guard let tommorowStartOfDay = Date().getTomorrow()?.startOfDay else {
            print("cant get start of next day")
            return
        }
        
        let timer = Timer(fire: tommorowStartOfDay, interval: 0, repeats: false, block: { [weak self] _ in
            self?.timerService.removeAll()
            self?.inProgress.removeAll()
            self?.completed.removeAll()
            
            self?.synchronizationService.validateResults()
            self?.dateEndTimer?.invalidate()
            self?.setEndDayHandler()
            self?.dateIsOver.value = ()
        })
        dateEndTimer = timer
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func refresh() {
    }
    
    func addTask() {
        router.trigger(.create)
    }
    
    func edit(task indexPath: IndexPath) {
        guard let task = getTask(for: indexPath) else {
            return
        }
        
        if let _ = task.courseTaskId {
            router.trigger(.editCourseTask(task: task))
        } else {
            router.trigger(.editUserTask(task: task))
        }
    }
    
    func remove(task indexPath: IndexPath) {
        guard let task = getTask(for: indexPath) else {
            return
        }
        timerService.remove(task: task)
        synchronizationService.remove(task: task)
    }
    
    func showCountPicker(task: Task, result: RealmTaskResult, change: CountChange) {
        router.trigger(.showCountPicker(task: task, result: result, change: change))
    }
    
    func updateTable() {
        update.value = Void()
    }
    
    func getProgress(for date: Date) -> CalendarDayProgress {
        print("get calendar progress for \(date)")
        
        let results = database.getTasks(for: date)
            .flatMap { $0.taskResults }
            .filter { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) }
        
        switch Calendar.autoupdatingCurrent.compare(date, to: Date(), toGranularity: .day) {
        case .orderedSame:
            // текущая дата
            // если все задачи выполнены
            guard results.count > .zero else {
                return .notStarted
            }
            
            if results.filter({ $0.progress == .done }).count == results.count {
                return .inProgress
            }
            
            if let _ = results.first(where: { $0.progress == .inProgress }) {
                return .inProgress
            } else {
                return .notStarted
            }
            
        case .orderedAscending:
            // дата в прошлом
            guard results.count > .zero else {
                return .future
            }

            if let _ = results.first(where: { $0.progress == .failed }) {
                return .failed
            } else {
                return .complete
            }
            
        case .orderedDescending:
            // дата в будущем
            return .future
        }
    }
    
    func dateChanged(_ date: Date) {
        print("date Changed")
        let resultHelper = synchronizationService.resultHelper
        var inProgressTasks: [Task] = []
        var completedTasks: [Task] = []
        lastSelectedDate = date
        
        switch Calendar.autoupdatingCurrent.compare(date, to: Date(), toGranularity: .day) {
        case .orderedSame:
            // текущая дата
            let tasksWithResult = database.getTasks(for: date)
            let todayTasks = database.getTasks().filter { resultHelper.isTask($0, belongs: date) }
            let tasksWithoutResult = Set(todayTasks).subtracting(tasksWithResult)
            
            // создать результат на сегодня для задач без результатов
            tasksWithoutResult.forEach {
                database.createResult(for: $0, date: nil)
            }
            inProgressTasks = getFilteredTasks(for: date, .notFinished)
            completedTasks = getFilteredTasks(for: date, .finished)
            
        case .orderedAscending:
            // дата в прошлом
            inProgressTasks = database.getTasks(for: date)
            
        case .orderedDescending:
            // дата в будущем
            inProgressTasks = database.getTasks()
                .filter { resultHelper.isTask($0, belongs: date) }
        }
        
        inProgress = sort(inProgressTasks).map { infoProvider.convert(task: $0, for: date) }
        completed = sort(completedTasks).map { infoProvider.convert(task: $0, for: date) }
        continueTimerIfNeeded()
        updateTable()
    }
    
    private func continueTimerIfNeeded() {
        inProgress
            .filter { $0.task.taskType == .TIMER && $0.progressModel.state == .inProgress }
            .forEach {
                guard let result = $0.progressModel.result else {
                    return
                }
                timerService.subscribe(task: $0.task, result: result)
            }
    }
}

extension TodayTasksViewModelImpl: TaskCellModelDelegate, TaskActionDelegate, ProgressActionDelegate {
    func startCounter(result: RealmTaskResult) {
        database.update(result: result, progress: .inProgress)
    }
    
    func changeCounter(task: Task, result: RealmTaskResult) {
        showCountPicker(task: task, result: result, change: .set)
    }
    
    func completeCheckbox(result: RealmTaskResult) {
        database.update(result: result, value: String(), isCompleted: true)
        database.update(result: result, progress: .done)
    }
    
    func openTextAnswer(task: Task, result: RealmTaskResult) {
        router.trigger(.openTextAnswer(task: task, result: result))
    }
    
    func startTimer(task: Task, result: RealmTaskResult) {
        database.update(result: result, progress: .inProgress)
        timerService.subscribe(task: task, result: result)
    }
    
    func stopTimer(task: Task, result: RealmTaskResult) {
        timerService.remove(task: task)
        if result.isComplete {
            database.update(result: result, progress: .done)
        } else {
            database.update(result: result, progress: .notStarted)
        }
    }
    
    
    func minusDidTap(task: Task, result: RealmTaskResult) {
        showCountPicker(task: task, result: result, change: .substract)
    }
    
    func plusDidTap(task: Task, result: RealmTaskResult) {
        showCountPicker(task: task, result: result, change: .add)
    }
    
    
    func taskDidRemove() {
        var model: TaskCellModel?
        var section: TaskFilter?
        var index: Int?
        
        if let progressIndex = inProgress.firstIndex(where: { $0.task.isInvalidated } ) {
            model = inProgress[progressIndex]
            section = .notFinished
            index = progressIndex
        } else if let completedIndex = completed.firstIndex(where: { $0.task.isInvalidated } ) {
            model = inProgress[completedIndex]
            section = .finished
            index = completedIndex
        }
        
        guard let model = model, let section = section, let index = index else {
            print("cant resolve data to remove model from tasks list")
            return
        }
        update(model, .remove, in: section, with: index)
    }
    
    func resultValueDidChange(for task: Task, new result: String) {
        print("task \(task.taskName) new result value \(result)")
        
        if let inProgressIndex = inProgress.firstIndex(where: { $0.task.internalID == task.internalID }) {
            reloadUpdate.value = IndexPath(row: inProgressIndex, section: 0)
        } else if let completedIndex = completed.firstIndex(where: { $0.task.internalID == task.internalID }) {
            reloadUpdate.value = IndexPath(row: completedIndex, section: 1)
        }
    }
    
    func progressDidChange(for task: Task, new progress: TaskProgress) {
        print("task \(task.taskName) new progress \(progress)")
        guard let date = lastSelectedDate else {
            return
        }
        let model = infoProvider.convert(task: task, for: date)
        
        // переместить из списка `выполняемых` в список `выполненных`
        if progress == .done {
            guard
                let oldIndex = inProgress.firstIndex(where: { $0.task.internalID == task.internalID }),
                let newIndex = sort(getFilteredTasks(for: date, .finished)).firstIndex(where: { $0.internalID == task.internalID })
            else {
                return
            }
            update(model, .remove, in: .notFinished, with: oldIndex)
            update(model, .insert, in: .finished, with: newIndex)
        } else {
            if let oldIndex = completed.firstIndex(where: { $0.task.internalID == task.internalID } ) {
                update(model, .remove, in: .finished, with: oldIndex)
            } else if let oldIndex = inProgress.firstIndex(where: { $0.task.internalID == task.internalID }) {
                update(model, .remove, in: .notFinished, with: oldIndex)
            }
            
            guard let newIndex = sort(getFilteredTasks(for: date, .notFinished)).firstIndex(where: { $0.internalID == task.internalID }) else {
                return
            }
            update(model, .insert, in: .notFinished, with: newIndex)
        }
    }
    
    private func update(_ model: TaskCellModel, _ update: TaskUpdate, in filter: TaskFilter, with index: Int) {
        switch (filter, update) {
        case (.finished, .insert):
            completed.insert(model, at: index)
            insertUpdate.value = IndexPath(row: index, section: 1)
            
        case (.finished, .remove):
            completed.remove(at: index)
            removeUpdate.value = IndexPath(row: index, section: 1)
            
        case (.notFinished, .insert):
            inProgress.insert(model, at: index)
            insertUpdate.value = IndexPath(row: index, section: 0)
            
        case (.notFinished, .remove):
            inProgress.remove(at: index)
            removeUpdate.value = IndexPath(row: index, section: 0)
            
        default:
            break
        }
    }
    
    private func getFilteredTasks(for date: Date, _ filter: TaskFilter) -> [Task] {
        database.getTasks(for: date).filter {
            $0.taskResults.contains { result in
                filter.getCondition(for: result, date: date)
            }
        }
    }
   
    private func sort(_ tasks: [Task]) -> [Task] {
        return tasks.sorted {
            let firstProgress = getResult(of: $0)?.progress ?? .notStarted
            let secondProgress = getResult(of: $1)?.progress ?? .notStarted
            return (firstProgress, $0.taskSanction) > (secondProgress, $1.taskSanction)
        }
    }
    
    private func getResult(of task: Task) -> RealmTaskResult? {
        guard let date = lastSelectedDate else {
            print("cant get last selected date result for task \(task.taskName)")
            return nil
        }
        return task.taskResults.first(where: { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) })
    }
    
    private func getTask(for indexPath: IndexPath) -> Task? {
        var task: Task?
        
        switch indexPath.section {
        case 0:
            task = inProgress[indexPath.row].task
        case 1:
            task = completed[indexPath.row].task
        default:
            break
        }
        return task
    }
    
}
