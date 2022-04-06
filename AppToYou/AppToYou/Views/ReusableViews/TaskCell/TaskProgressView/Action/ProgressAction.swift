import Foundation


/**
 Протокол действия привязанный к прогрессу задачи.
 */
protocol ProgressAction: AnyObject {
    /**
     Обработчик действия.
     */
    var delegate: ProgressActionDelegate? { get set }
    
    /**
     Выполнить установленное действие.
     */
    func execute(for task: Task, with result: RealmTaskResult)
}
