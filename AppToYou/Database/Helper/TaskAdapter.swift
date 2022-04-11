import Foundation


class TaskAdapter {
    
    func convert(userTaskResponse: UserTaskResponse) -> Task? {
        guard
            let data = try? JSONEncoder().encode(userTaskResponse),
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
            print("can`t create `Task` from `UserTaskResponse`")
            return nil
        }
        
        return Task(value: json)
    }
    
    func convert(courseTaskResponse: CourseTaskResponse) -> Task? {
        guard
            let data = try? JSONEncoder().encode(courseTaskResponse),
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
            print("can`t create `Task` from `CourseTaskResponse`")
            return nil
        }
        
        return Task(value: json)
    }
     
    func convert<Result: Decodable>(task: Task, to result: Result.Type) -> Result? {
        guard
            let taskData = try? JSONSerialization.data(withJSONObject: task.toDictionary(), options: []),
            let result = try? JSONDecoder().decode(result, from: taskData)
        else {
            return nil
        }
        return result
    }
    
}
