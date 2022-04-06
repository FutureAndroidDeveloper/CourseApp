import Foundation


/**
 Действие уменьшения количества выполненных повторов у задаче.
 */
class SubtractCountAction: TaskAction {
    weak var delegate: TaskActionDelegate?
    
    /**
     Уменьшить количетсво выполненных повторов.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("minus action tapped")
        delegate?.minusDidTap(task: task, result: result)
    }
}
