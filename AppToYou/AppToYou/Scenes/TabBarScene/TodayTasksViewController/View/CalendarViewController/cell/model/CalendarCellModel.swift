import Foundation


class CalendarCellModel {
    let date: Date
    let weekdayTitle: String
    let dateLabel: String
    private(set) var progress: CalendarDayProgress
    
    var selectHandler: ((Bool) -> Void)?
    var isSelected: Bool
    
    init(date: Date, progress: CalendarDayProgress = .future) {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: date) - 1
        let weekday = calendar.shortWeekdaySymbols[weekdayIndex].lowercased()
        let day = calendar.component(.day, from: date)
        
        self.weekdayTitle = weekday
        self.dateLabel = "\(day)"
        self.progress = progress
        self.date = date
        self.isSelected = false
    }
    
    func update(progress: CalendarDayProgress) {
        self.progress = progress
    }
    
    func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
        selectHandler?(isSelected)
    }
    
}
