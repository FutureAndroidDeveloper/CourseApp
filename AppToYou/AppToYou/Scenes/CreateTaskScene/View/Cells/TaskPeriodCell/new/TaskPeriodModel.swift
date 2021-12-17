import Foundation


class TaskPeriodModel {
    
    let start: DateFieldModel
    let end: DateFieldModel
    
    init(start: DateFieldModel, end: DateFieldModel) {
        self.start = start
        self.end = end
    }
    
}
