import Foundation


class TaskResult: Codable {
    var date: String
    var isComplete: Bool
    var result: String
    
    init(date: String, isComplete: Bool, result: String) {
        self.date = date
        self.isComplete = isComplete
        self.result = result
    }
    
}
