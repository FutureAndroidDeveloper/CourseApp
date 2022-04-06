import Foundation


class CourseTaskHintModel {
    let title: String?
    let currency: CourseTaskCurrency
    
    init(title: String?, currency: CourseTaskCurrency) {
        self.title = title
        self.currency = currency
    }
    
}
