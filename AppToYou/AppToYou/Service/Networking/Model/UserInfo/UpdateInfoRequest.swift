import Foundation


class UpdateInfoRequest: Encodable {
    let removedUserTaskIdList: [Int]?
    let sanctionList: [SanctionCreateRequest]?
    let statistics: StatisticsRequest?
    let transactionList: [TransactionRequest]?
    let userAchievementList: [UserAchievementRequest]?
    let userTaskList: [UserTaskResponse]?
    let vacationList: [VacationResponse]?
    
    init(
        removedUserTaskIdList: [Int]? = nil, sanctionList: [SanctionCreateRequest]? = nil, statistics: StatisticsRequest? = nil,
        transactionList: [TransactionRequest]? = nil, userAchievementList: [UserAchievementRequest]? = nil,
        userTaskList: [UserTaskResponse]? = nil, vacationList: [VacationResponse]? = nil
    ) {
        self.removedUserTaskIdList = removedUserTaskIdList
        self.sanctionList = sanctionList
        self.statistics = statistics
        self.transactionList = transactionList
        self.userAchievementList = userAchievementList
        self.userTaskList = userTaskList
        self.vacationList = vacationList
    }
}
