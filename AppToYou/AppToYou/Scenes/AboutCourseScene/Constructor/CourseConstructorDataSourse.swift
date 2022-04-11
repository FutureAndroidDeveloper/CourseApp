import UIKit


protocol CourseConstructorDataSourse: AnyObject {
    func getUsersAmount() -> Int
    func getDuration() -> Duration?
    func getPrice() -> Price
    func getAdminPhoto() -> UIImage?
    
    func isTaskAddedToUser(_ task: Task) -> Bool
    
    func getName() -> String
    func getDescription() -> String
    func getType() -> ATYCourseType
    func getLikes() -> Int
    func getRequests() -> Int
    func getPickedTasks() -> (amount: Int, picked: Int)
    func getMembers() -> CourseMembersViewModel
}
