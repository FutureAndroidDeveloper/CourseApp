import Foundation


class TaskManager: NetworkManager<TaskEndpoint> {
    
    func create(task: UserTaskCreateRequest, completion: @escaping (Result<UserTaskResponse, NetworkResponseError>) -> Void) {
        request(.create(task: task), responseType: UserTaskResponse.self, completion)
    }
    
    func update(task: UserTaskUpdateRequest, completion: @escaping (Result<UserTaskResponse, NetworkResponseError>) -> Void) {
        request(.update(task: task), responseType: UserTaskResponse.self, completion)
    }
    
    func getTaskFullList(completion: @escaping (Result<[UserTaskResponse], NetworkResponseError>) -> Void) {
        request(.fullList, responseType: [UserTaskResponse].self, completion)
    }
    
}
