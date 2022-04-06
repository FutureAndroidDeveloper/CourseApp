import Foundation


/**
 Протокол действия над задачей.
 */
protocol TaskAction: AnyObject {
    /**
     Обработчик действия.
     */
    var delegate: TaskActionDelegate? { get set }
    
    /**
     Выполнить установленное действие.
     */
    func execute(for task: Task, with result: RealmTaskResult)
}
