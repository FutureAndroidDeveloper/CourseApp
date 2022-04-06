import Foundation


/**
 Действие переключения задачи подсчета повторений в активное состояние.
 */
class StartCounterProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Начать выполнение задачи на подсчет повторений.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("start counter")
        delegate?.startCounter(result: result)
    }
}
