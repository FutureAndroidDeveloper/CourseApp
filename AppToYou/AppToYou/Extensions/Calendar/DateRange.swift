import Foundation


struct DateRange : Sequence, IteratorProtocol {
    var calendar: Calendar
    var startDate: Date
    var endDate: Date
    var component: Calendar.Component
    var step: Int
    var multiplier: Int
    
    mutating func next() -> Date? {
        guard let nextDate = calendar.date(byAdding: component, value: step * multiplier, to: startDate)
        else {
            return nil
        }
        
        if nextDate > endDate {
            return nil
        } else {
            multiplier += 1
            return nextDate
        }
    }
}
