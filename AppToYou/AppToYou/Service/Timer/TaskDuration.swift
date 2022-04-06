import Foundation


struct TaskDuration: CustomStringConvertible {
    let hour: Int
    let min: Int
    let sec: Int
    
    var description: String {
        let hourText = hour != .zero ? "\(hour) час" : nil
        let minText = min != .zero ? "\(min) мин" : nil
        let secText = sec != .zero ? "\(sec) сек" : nil
        
        return [hourText, minText, secText]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
