import Foundation


protocol CourseConstructorDelegate: AnyObject {
    func back()
    func edit()
    func like(_ isFavorite: Bool)
    
    func openRequests()
    func openChat()
    
    func addTasks()
    func createTask()
    
    func openMemebrs()
    func share()
    func report()
}
