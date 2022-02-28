import Foundation


class TaskDescriptionProvider {
    
    private struct Constants {
        static let timeSeparator: Character = ":"
        static let unknownDescription = "N/A"
        static let everyday = "каждый день"
        static let weekdays = "по будням"
        static let monthly = "ежемесячно"
        static let yearly = "ежегодно"
        static let activeDayCode: Character = "1"
        static let symbols = "символов"
        static let counts = "раз"
        static let descriptionSeparator = "•"
    }
    
    func convert(task: UserTaskResponse) -> TaskDescriptionModel {
        var desription = String()
        
        switch task.frequencyType {
        case .ONCE:
            let date = task.startDate.toDate(dateFormat: .localeYearDate)
            desription = date?.toString(dateFormat: .localeDayMonthYear) ?? Constants.unknownDescription
        case .EVERYDAY:
            desription = Constants.everyday
        case .WEEKDAYS:
            desription = Constants.weekdays
        case .MONTHLY:
            desription = Constants.monthly
        case .YEARLY:
            desription = Constants.yearly
        case .CERTAIN_DAYS:
            let calendar = Calendar.autoupdatingCurrent
            let weekdaySymbols = calendar.shortWeekdaySymbols
            let bound = calendar.firstWeekday - 1
            let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
            var resultDays = [String]()
            
            if let daysCode = task.daysCode {
                let codeArray = Array(daysCode)
                zip(orderedSymbols, codeArray).forEach { item in
                    if item.1 == Constants.activeDayCode {
                        resultDays.append(item.0)
                    }
                }
            }
            desription = resultDays.joined(separator: ", ")
        }
        
        switch task.taskType {
        case .CHECKBOX:
            break
        case .TEXT:
            let textLength = task.taskAttribute ?? String()
            desription += " \(Constants.descriptionSeparator) \(textLength) \(Constants.symbols)"
        case .RITUAL:
            let count = task.taskAttribute ?? String()
            desription += " \(Constants.descriptionSeparator) \(count) \(Constants.counts)"
        case .TIMER:
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

            let duration = TaskDuration(hour: hour, min: min, sec: sec)
            desription += " \(Constants.descriptionSeparator) \(duration.description)"
        }
        
        return TaskDescriptionModel(title: task.taskName, description: desription)
    }
    
}
