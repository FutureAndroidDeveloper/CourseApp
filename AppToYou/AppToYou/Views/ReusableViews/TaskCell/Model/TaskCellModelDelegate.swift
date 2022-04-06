import Foundation


/**
 Протокол получения уведомлений об изменении состояния модели задачи.
 */
protocol TaskCellModelDelegate: AnyObject {
    /**
     Задача удалена.
     */
    func taskDidRemove()
    
    /**
     Прогресс задачи изменен.
     */
    func progressDidChange(for task: Task, new progress: TaskProgress)
    
    /**
     Значение результата задачи изменено.
     */
    func resultValueDidChange(for task: Task, new result: String)
}
