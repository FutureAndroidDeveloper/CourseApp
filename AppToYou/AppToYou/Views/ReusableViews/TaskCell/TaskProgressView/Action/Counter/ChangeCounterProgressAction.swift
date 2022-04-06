import Foundation


/**
 Действие изменения количества выполненных повторов в задаче на подсчет повторений.
 */
class ChangeCounterProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Изменить количество выполненных повторений.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("open count change picker")
        delegate?.changeCounter(task: task, result: result)
    }
}
