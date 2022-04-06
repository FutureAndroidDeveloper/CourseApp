import Foundation


/**
 Действие запуска таймера задачи.
 */
class StartTimerProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Запустить таймер задачи.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("start timer action")
        delegate?.startTimer(task: task, result: result)
    }
}
