import Foundation


class FrequencyPickerFactory {
    
    static let standartOrder: [[ATYFrequencyTypeEnum]] = [
        [.EVERYDAY, .WEEKDAYS],
        [.MONTHLY, .YEARLY],
        [.ONCE, .CERTAIN_DAYS],
    ]
    
    static let createCourseTaskOrder: [[ATYFrequencyTypeEnum]] = [
        [.EVERYDAY, .WEEKDAYS],
        [.MONTHLY, .YEARLY],
        [.CERTAIN_DAYS],
    ]
    
    
    static func getFrequencyOrder(for mode: CreateTaskMode) -> [[ATYFrequencyTypeEnum]] {
        switch mode {
        case .createUserTask, .editUserTask, .addCourseTask:
            return standartOrder
            
        case .createCourseTask, .editCourseTask, .adminEditCourseTask:
            return createCourseTaskOrder
        }
    }
    
}
