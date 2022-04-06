import Foundation



protocol TodayTasksViewModelInput: AnyObject {
    func addTask()
    func refresh()
    func edit(task indexPath: IndexPath)
    func remove(task indexPath: IndexPath)
    func showCountPicker(task: Task, result: RealmTaskResult, change: CountChange)
    
    func dateChanged(_ date: Date)
}


protocol TodayTasksViewModelOutput: AnyObject {
    func getProgress(for date: Date) -> CalendarDayProgress
    func getTaskHintState() -> Bool
    
    var update: Observable<Void> { get set }
    
    var refreshDate: Observable<Void> { get set }
    
    var completed: [TaskCellModel] { get }
    var inProgress: [TaskCellModel] { get }
    
    var insertUpdate: Observable<IndexPath> { get set }
    var removeUpdate: Observable<IndexPath> { get set }
    var reloadUpdate: Observable<IndexPath> { get set }
    var dateIsOver: Observable<Void> { get set }
}


protocol TodayTasksViewModel: AnyObject {
    var input: TodayTasksViewModelInput { get }
    var output: TodayTasksViewModelOutput { get }
}


extension TodayTasksViewModel where Self: TodayTasksViewModelInput & TodayTasksViewModelOutput {
    var input: TodayTasksViewModelInput { return self }
    var output: TodayTasksViewModelOutput { return self }
}
