import Foundation


/**
 Базовая модель прогресса выполнения задачи.
 
 Отвечает за настройку отображаемого значения прогресса и действий по нажатию по нему.
 */
class TaskProgressModel {
    weak var delegate: ProgressActionDelegate?
    
    let result: RealmTaskResult?
    let type: TaskType
    var state: TaskProgress {
        result?.progress ?? .notStarted
    }
    private(set) var task: Task
    
    init(task: Task, date: Date) {
        result = task.taskResults.first(where: { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) })
        type = task.taskType
        self.task = task
    }
    
    /**
     Получить значение текущего прогресса задачи.
     */
    func getProgressValue() -> Any? {
        return nil
    }
    
    /**
     Выполнить привязанное действие прогресса над задачей.
     */
    func executeAction() {
        guard let result = result else {
            return
        }
        let action = getAction()
        action?.delegate = delegate
        action?.execute(for: task, with: result)
    }
    
    private func getAction() -> ProgressAction? {
        guard let result = result, result.date.starts(with: Date().toString(dateFormat: .localeYearDate)) else {
            print("cant get progress action for task '\(task.taskName)'")
            return nil
        }
        
        var action: ProgressAction?

        switch (type, result.progress) {
        case (.RITUAL, .notStarted):
            action = StartCounterProgressAction()
        case (.RITUAL, .inProgress):
            action = ChangeCounterProgressAction()
            
        case (.CHECKBOX, .notStarted):
            action = CompleteCheckboxProgressAction()
            
        case (.TEXT, .notStarted): fallthrough
        case (.TEXT, .inProgress):
            action = OpenTextAnswerProgressAction()
            
        case (.TIMER, .notStarted): fallthrough
        case (.TIMER, .done):
            action = StartTimerProgressAction()
        case (.TIMER, .inProgress):
            action = StopTimerProgressAction()
            
        default:
            break
        }
        return action
    }
    
}
