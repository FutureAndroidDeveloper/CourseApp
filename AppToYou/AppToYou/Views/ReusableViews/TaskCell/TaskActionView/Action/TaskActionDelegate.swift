import Foundation


protocol TaskActionDelegate: AnyObject {
    func minusDidTap(task: Task, result: RealmTaskResult)
    func plusDidTap(task: Task, result: RealmTaskResult)
}
