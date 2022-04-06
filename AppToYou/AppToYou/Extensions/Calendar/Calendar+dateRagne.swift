import Foundation


extension Calendar {
    func dateRange(startDate: Date, endDate: Date, component: Calendar.Component, step: Int) -> DateRange {
        let dateRange = DateRange(calendar: self, startDate: startDate, endDate: endDate, component: component, step: step, multiplier: 0)
        return dateRange
    }
}
