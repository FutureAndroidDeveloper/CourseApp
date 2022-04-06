import Foundation


/**
 Действие добавления количества выполненных повторов к задаче.
 */
class AddCountAction: TaskAction {
    weak var delegate: TaskActionDelegate?
    
    /**
     Добавить количетсво выполненных повторов.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("plus action tapped")
        delegate?.plusDidTap(task: task, result: result)
    }
}
