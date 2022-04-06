import Foundation


protocol ProgressActionDelegate: AnyObject {
    func startCounter(result: RealmTaskResult)
    func changeCounter(task: Task, result: RealmTaskResult)
    
    func completeCheckbox(result: RealmTaskResult)
    func openTextAnswer(task: Task, result: RealmTaskResult)
    
    func startTimer(task: Task, result: RealmTaskResult)
    func stopTimer(task: Task, result: RealmTaskResult)
}
