import Foundation


class AddTaskAttributeModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}





class AddTaskFieldFactory {
    
    private let taskType: ATYTaskType
    
    init(taskType: ATYTaskType) {
        self.taskType = taskType
    }
    
    
    func getTitle() -> String? {
        switch taskType {
        case .CHECKBOX:
            return nil
        case .TEXT:
            return "Выберите оптимальное для вас количество символов для выполнения задачи"
        case .TIMER:
            return "Выберите оптимальную для вас длительность выполнения задачи"
        case .RITUAL:
            return "Выберите оптимальное для вас количество повторений выполнения задачи"
        }
    }
    
    
}
