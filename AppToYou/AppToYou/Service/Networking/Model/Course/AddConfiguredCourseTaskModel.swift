import Foundation



class AddConfiguredCourseTaskModel {
    let courseId: Int
    let taskId: Int
    var attribute: String?
    var sanction: Int?
    
    init(courseId: Int, taskId: Int, attribute: String? = nil, sanction: Int? = nil) {
        self.courseId = courseId
        self.taskId = taskId
        self.attribute = attribute
        self.sanction = sanction
    }
    
    func getParameters() -> [Parameter] {
        var parameters = [Parameter]()
        
        if let attribute = attribute {
            let attributeParameter = Parameter(name: "taskAttribute", value: attribute)
            parameters.append(attributeParameter)
        }
        if let sanction = sanction {
            let sanctionParameter = Parameter(name: "taskSanction", value: sanction)
            parameters.append(sanctionParameter)
        }
        let taskIdParameter = Parameter(name: "taskId", value: taskId)
        parameters.append(taskIdParameter)
        
        return parameters
    }
    
}
