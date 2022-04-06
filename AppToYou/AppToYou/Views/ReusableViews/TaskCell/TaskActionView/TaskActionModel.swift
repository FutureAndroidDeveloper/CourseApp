import Foundation


/**
 Базовая модель действия над задачей.
 
 Отвечает за получение настроек представления действия и его выполнения.
 */
class TaskActionModel {
    weak var delegate: TaskActionDelegate?
    
    let result: RealmTaskResult?
    var state: TaskProgress {
        result?.progress ?? .notStarted
    }
    private let task: Task
    
    init(task: Task, date: Date) {
        result = task.taskResults.first(where: { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) })
        self.task = task
    }
    
    /**
     Выполнить привязанное действие над задачей.
     */
    func execute(action: TaskAction) {
        guard let result = result else {
            print("cant find result for action")
            return
        }

        action.delegate = delegate
        action.execute(for: task, with: result)
    }
    
    /**
     Получить конфигурация представления действия над задачей.
     */
    func getConfiguration() -> Any? {
        return nil
    }
    
}
