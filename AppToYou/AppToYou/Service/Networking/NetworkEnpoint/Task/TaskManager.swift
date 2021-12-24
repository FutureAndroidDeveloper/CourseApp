import Foundation


class TaskManager: NetworkManager<TaskEndpoint> {
    
    func create(task: UserTaskCreateRequest, completion: @escaping (Result<UserTaskCreateRequest, NetworkResponseError>) -> Void) {
        request(.create(task: task), responseType: UserTaskCreateRequest.self, completion)
    }
    
}
