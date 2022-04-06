import Foundation


/**
 Действие остановки таймера задачи.
 */
class StopTimerProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Остановить таймер задачи.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("stop timer action")
        delegate?.stopTimer(task: task, result: result)
    }
}
