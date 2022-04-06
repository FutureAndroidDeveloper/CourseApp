import Foundation


protocol DatabaseDifferenceDelegate: AnyObject {
    func localTaskDidAdd(_ task: Task)
    func localTaskDidEdit(_ task: Task)
    func localTaskDidRemove(id: Int)
    
    func serverTasksDidAdd(_ task: Task)
    func serverTaskDidEdit(local: Task, server: Task)
    func serverTaskDidRemove(_ task: Task)
    
    func reset()
}
