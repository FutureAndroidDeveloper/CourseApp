import Foundation


/**
 Действие ввода ответа для задачи `Текст.
 */
class OpenTextAnswerProgressAction: ProgressAction {
    weak var delegate: ProgressActionDelegate?
    
    /**
     Перейти к вводу ответа для задачи.
     */
    func execute(for task: Task, with result: RealmTaskResult) {
        print("open text answer")
        delegate?.openTextAnswer(task: task, result: result)
    }
}
