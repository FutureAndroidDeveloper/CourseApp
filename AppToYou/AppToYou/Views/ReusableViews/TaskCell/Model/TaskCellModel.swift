import Foundation
import RealmSwift


/**
 Модель представления ячейки задачи.
 
 1. Содержит данные для отображения.
 2. Наблюдает за изменениями в задаче. Посылает уведомления об изменениях делегату.
 */
class TaskCellModel {
    private struct Constants {
        static let observedProgressName = "progress"
        static let observerResultName = "result"
    }
    
    weak var delegate: TaskCellModelDelegate?
    
    let task: Task
    let progressModel: TaskProgressModel
    let descriptionModel: TaskDescriptionModel
    let hintModel: CourseTaskHintModel?
    let actionModel: TaskActionModel?
    
    private var progressToken: NotificationToken?
    private var resultToken: NotificationToken?
    private var removeToken: NotificationToken?
    
    
    init(task: Task, date: Date, progressModel: TaskProgressModel, descriptionModel: TaskDescriptionModel,
         hintModel: CourseTaskHintModel?, actionModel: TaskActionModel?) {
        self.task = task
        self.progressModel = progressModel
        self.descriptionModel = descriptionModel
        self.hintModel = hintModel
        self.actionModel = actionModel
        
        setRemoveHandler()
        setStateHandler(date)
        setResultHandler(date)
    }
    
    deinit {
        progressToken?.invalidate()
        resultToken?.invalidate()
        removeToken?.invalidate()
    }
    
    private func setRemoveHandler() {
        removeToken = task.observe { [weak self] change in
            switch change {
            case .deleted:
                self?.delegate?.taskDidRemove()
            default:
                break
            }
        }
    }
    
    private func setStateHandler(_ date: Date) {
        guard let result = task.taskResults.first(where: { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) }) else {
            print("cant get task result for task '\(task.taskName)', date '\(date)'")
            return
        }
        
        progressToken = result.observe { [weak self] change in
            guard let self = self else {
                return
            }
            switch change {
            case .change(_, let properties):
                guard
                    let property = properties.first(where: { $0.name == Constants.observedProgressName }),
                    let rawValue = property.newValue as? String,
                    let progress = TaskProgress(rawValue: rawValue)
                else {
                    return
                }
                self.delegate?.progressDidChange(for: self.task, new: progress)
                
            default:
                break
            }
        }
    }
    
    private func setResultHandler(_ date: Date) {
        guard let result = task.taskResults.first(where: { $0.date.starts(with: date.toString(dateFormat: .localeYearDate)) }) else {
            print("cant get task result for task '\(task.taskName)', date '\(date)'")
            return
        }
        
        resultToken = result.observe { [weak self] change in
            guard let self = self else {
                return
            }
            switch change {
            case .change(_, let properties):
                guard
                    let property = properties.first(where: { $0.name == Constants.observerResultName }),
                    let resultValue = property.newValue as? String
                else {
                    return
                }
                self.delegate?.resultValueDidChange(for: self.task, new: resultValue)
                
            default:
                break
            }
        }
    }
    
}
