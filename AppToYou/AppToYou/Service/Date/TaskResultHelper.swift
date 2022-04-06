import Foundation


/**
 Вспомогательный класс для валидации результотов задачи в прошлом.
 Предоставляет дополнителыный функционал проверки принадлежности задачи к определенной дате.
 */
class TaskResultHelper {
    private struct Constants {
        static let activeDayCode = "1"
    }
    
    weak var delegate: TaskResultHelperDelegate?
    private let calendar = Calendar.autoupdatingCurrent
    
    
    /**
     Поиск задач, у которых результаты на прошедшие дни соответствуют условиям:
     
     1. отсутствует результат выполенения задачи в прошлом
     2. задача выполнена, прогресс не соответсвует
     3. задача не выполнена, прогресс не соответсвует
     */
    func validateResult(for task: Task) {
        guard
            let startDate = task.startDate.toDate(dateFormat: .localeYearDate),
            let endDate = calendar.date(byAdding: .day, value: -1, to: Date())
        else {
            return
        }
        
        // диапозон дат [дата начала задачи; (текущая дата - 1 день)]
        let dateRange = calendar.dateRange(startDate: startDate, endDate: endDate, component: .day, step: 1)
        
        // skippedDates (поиск дат, у которых отсутствует результат)
        dateRange
            .filter { isTask(task, belongs: $0) }
            .filter { date -> Bool in
                let resultExists = task.taskResults.contains {
                    return $0.date.starts(with: date.toString(dateFormat: .localeYearDate))
                }
                return !resultExists
            }
            .forEach {
                delegate?.didFindTaskWithoutResult(task, for: $0)
            }
        
        // поиск результатов, у которых прогресс не соответствует статусу выполнения
        // resultsWithIncorrectProgress
        task.taskResults
            .filter { result in
                guard let date = result.date.toDate(dateFormat: .localeYearDate) else {
                    return false
                }
                return dateRange.contains(date) && result.isComplete && result.progress != .done
            }
            .forEach {
                delegate?.didFindUncompletedTaskResult($0, newProgress: .done)
            }
        
        // uncompletedResults
        task.taskResults
            .filter { result in
                guard let date = result.date.toDate(dateFormat: .localeYearDate) else {
                    return false
                }
                return dateRange.contains(date) && !result.isComplete && result.progress != .failed
            }
            .forEach {
                delegate?.didFindUncompletedTaskResult($0, newProgress: .failed)
            }
    }
    
    /**
     Определить, принадлежит ли задача определенной дате.
     */
    func isTask(_ task: Task, belongs date: Date) -> Bool {
        var result = false
        
        guard let start = task.startDate.toDate(dateFormat: .localeYearDate) else {
            print("To compare dates need to set start date of task")
            return result
        }
        
        switch task.frequencyType {
        case .ONCE:
            result = calendar.compare(start, to: date, toGranularity: .day) == .orderedSame
            
        case .EVERYDAY:
            result = checkFrequencyCondition(for: task, start: start, date: date, condition: {
                return true
            })
            
        case .WEEKDAYS:
            result = checkFrequencyCondition(for: task, start: start, date: date, condition: {
                return !calendar.isDateInWeekend(date)
            })
            
        case .MONTHLY:
            result = checkFrequencyCondition(for: task, start: start, date: date, condition: {
                guard
                    let monthsCount = calendar.dateComponents([.month], from: start, to: date).month,
                    let dateToCompare = calendar.date(byAdding: .month, value: -monthsCount, to: date)
                else {
                    print("cant get moths difference")
                    return false
                }
                return calendar.compare(start, to: dateToCompare, toGranularity: .day) == .orderedSame
            })
            
        case .YEARLY:
            result = checkFrequencyCondition(for: task, start: start, date: date, condition: {
                guard
                    let yearsCount = calendar.dateComponents([.year], from: start, to: date).year,
                    let dateToCompare = calendar.date(byAdding: .year, value: -yearsCount, to: date)
                else {
                    print("cant get years difference")
                    return false
                }
                return calendar.compare(start, to: dateToCompare, toGranularity: .day) == .orderedSame
            })
            
        case .CERTAIN_DAYS:
            result = checkFrequencyCondition(for: task, start: start, date: date, condition: {
                let weekdaySymbols = calendar.shortWeekdaySymbols
                let bound = calendar.firstWeekday - 1
                let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
                let models = orderedSymbols.map { WeekdayModel(title: $0) }
                
                if let daysCode = task.daysCode {
                    let codeArray = Array(daysCode)
                    zip(models, codeArray).forEach { item in
                        let isSelected = String(item.1) == Constants.activeDayCode
                        item.0.chandeSelectedState(isSelected)
                    }
                }
                
                let weekdayIndex = calendar.component(.weekday, from: date)
                return models[weekdayIndex - 1].isSelected
            })
        }
        
        return result
    }
    
    private func checkFrequencyCondition(for task: Task, start: Date, date: Date, condition: () -> Bool) -> Bool {
        var result = false
        
        if task.infiniteExecution {
            result = lessThanOrEqual(start, date) && condition()
        } else if let end = task.endDate?.toDate(dateFormat: .localeYearDate), !task.infiniteExecution {
            result = (start...end).contains(date) && condition()
        }
        
        return result
    }
    
    
    /**
     Левый операнд меньше либо равен правому.
     */
    private func lessThanOrEqual(_ a: Date, _ b: Date) -> Bool {
        let equals = calendar.compare(a, to: b, toGranularity: .day) == .orderedSame
        let less = calendar.compare(a, to: b, toGranularity: .day) == .orderedAscending
        return less || equals
    }
    
}
