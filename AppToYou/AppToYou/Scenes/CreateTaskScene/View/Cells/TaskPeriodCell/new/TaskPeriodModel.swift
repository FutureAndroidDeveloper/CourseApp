import Foundation


class TaskPeriodModel {
    
    let startPicked: DateCompletion
    let endPicked: DateCompletion
    
    init(startPicked: @escaping DateCompletion, endPicked: @escaping DateCompletion) {
        self.startPicked = startPicked
        self.endPicked = endPicked
    }
    
}
