import Foundation


class FrequencyPickerFactory {
    
    static let standartOrder: [[Frequency]] = [
        [.EVERYDAY, .WEEKDAYS],
        [.MONTHLY, .YEARLY],
        [.ONCE, .CERTAIN_DAYS],
    ]
    
    static let createCourseTaskOrder: [[Frequency]] = [
        [.EVERYDAY, .WEEKDAYS],
        [.MONTHLY, .YEARLY],
        [.CERTAIN_DAYS],
    ]
    
    
    static func getFrequencyOrder(for mode: CreateTaskMode) -> [[Frequency]] {
        switch mode {
        case .createUserTask, .editUserTask:
            return standartOrder
            
        case .createCourseTask, .editCourseTask, .adminEditCourseTask:
            return createCourseTaskOrder
        }
    }
    
}
