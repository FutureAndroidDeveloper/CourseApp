import Foundation


/**
  Модель действий над задачей на подсчет повторений.
 */
class TaskCounterActionModel: TaskActionModel {
    /**
     Получить конфигурацию действий для посчета для представления.
     */
    override func getConfiguration() -> Any? {
        var isHidden = false
        var minusIsHidden = false
        
        switch state {
        case .notStarted, .failed:
            isHidden = true
        case .inProgress:
            break
        case .done:
            // если конфигурация выполненной задачи в прошлом (не отображать action)
            if let date = result?.date, !date.starts(with: Date().toString(dateFormat: .localeYearDate)) {
                isHidden = true
            }
            minusIsHidden = true
        }
        
        return CounterActionConfiguration(isHidden: isHidden, minusIsHidden: minusIsHidden)
    }
}
