import Foundation


protocol TaskResultHelperDelegate: AnyObject {
    func didFindTaskWithoutResult(_ task: Task, for date: Date)
    func didFindUncompletedTaskResult(_ result: RealmTaskResult, newProgress: TaskProgress)
}
