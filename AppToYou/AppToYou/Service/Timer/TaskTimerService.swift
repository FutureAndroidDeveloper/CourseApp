import Foundation


/**
 Отвечает за обновление прогресса таймера результата задачи.
 */
class TaskTimerService {
    private struct Constants {
        static let timeSeparator: Character = ":"
    }
    
    private typealias Subscriber = (task: Task, result: RealmTaskResult)
    
    private let database: Database
    private let timer = TaskTimer()
    private var subscribers: [String: Subscriber] = [:]
    
    init(database: Database = RealmDatabase()) {
        self.database = database
        
        timer.tick = { [weak self] in
            self?.update()
        }
    }
    
    deinit {
        print("deinit task timer service")
        removeAll()
        timer.stopTimer()
    }
    
    /**
     Добавить подписчика получения обновления таймера.
     */
    func subscribe(task: Task, result: RealmTaskResult) {
        let subscriber = (task, result)
        let key = task.internalID.stringValue
        subscribers.updateValue(subscriber, forKey: key)
    }
    
     /**
      Удаление подписчика из числа получателей уведомлений об изменении таймера.
      */
    func remove(task: Task) {
        let key = task.internalID.stringValue
        subscribers.removeValue(forKey: key)
    }
    
    func removeAll() {
        subscribers.removeAll()
    }
    
    private func update() {
        subscribers.forEach { [weak self] (_, subscriber) in
            guard !subscriber.task.isInvalidated else {
                return
            }
            
            let duration = getTaskDuration(subscriber.task)
            let aimValue = Double(duration.hour * 60 * 60 + duration.min * 60 + duration.sec)
            let ellapsed = Double(subscriber.result.result ?? "0") ?? .zero
            let newValue = ellapsed + 1
            
            self?.database.update(result: subscriber.result, value: "\(newValue)", isCompleted: newValue >= aimValue)
        }
    }
    
    private func getTaskDuration(_ task: Task) -> TaskDuration {
        let attribute = task.taskAttribute ?? String()
        var hour = 0
        var min = 0
        var sec = 0
        
        attribute.split(separator: Constants.timeSeparator)
            .enumerated()
            .forEach { item in
                guard let value = Int(item.element) else {
                    return
                }
                switch item.offset {
                case 0: hour = value
                case 1: min = value
                case 2: sec = value
                default: break
                }
            }

        return TaskDuration(hour: hour, min: min, sec: sec)
    }
    
}
