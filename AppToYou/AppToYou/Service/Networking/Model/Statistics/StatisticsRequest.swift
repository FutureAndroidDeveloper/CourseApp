import Foundation


class StatisticsRequest: Encodable {
    let coinsSpent: Int?
    let createdCoursesAmount: Int?
    let currentDaysSeries: Int?
    let finishedCoursesAmount: Int?
    let invitedFriendsToTheCourses: Int?
    let maxCompletedTasksPerDay: Int?
    let maxDaysSeries: Int?
    
    init(
        coinsSpent: Int? = nil, createdCoursesAmount: Int? = nil, currentDaysSeries: Int? = nil, finishedCoursesAmount: Int? = nil,
        invitedFriendsToTheCourses: Int? = nil, maxCompletedTasksPerDay: Int? = nil, maxDaysSeries: Int? = nil
    ) {
        self.coinsSpent = coinsSpent
        self.createdCoursesAmount = createdCoursesAmount
        self.currentDaysSeries = currentDaysSeries
        self.finishedCoursesAmount = finishedCoursesAmount
        self.invitedFriendsToTheCourses = invitedFriendsToTheCourses
        self.maxCompletedTasksPerDay = maxCompletedTasksPerDay
        self.maxDaysSeries = maxDaysSeries
    }
}
