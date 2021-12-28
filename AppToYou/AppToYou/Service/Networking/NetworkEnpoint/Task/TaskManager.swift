import Foundation


class TaskManager: NetworkManager<TaskEndpoint> {
    
    func create(task: UserTaskCreateRequest, completion: @escaping (Result<UserTaskResponse, NetworkResponseError>) -> Void) {
        request(.create(task: task), responseType: UserTaskResponse.self, completion)
    }
    
}
