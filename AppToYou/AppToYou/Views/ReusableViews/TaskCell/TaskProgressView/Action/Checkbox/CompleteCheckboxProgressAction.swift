import Foundation


/**
 Действие выполнения разовой задачи.
 */
class CompleteCheckboxProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Выполнить разовую задачу.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("complete checkbox action")
        delegate?.completeCheckbox(result: result)
    }
}
