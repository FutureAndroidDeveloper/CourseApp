import Foundation
import XCoordinator


class CreateCourseTaskFactory {
    private let courseId: Int
    private let type: ATYTaskType
    private let mode: CreateTaskMode
    
    init(courseId: Int, type: ATYTaskType, mode: CreateTaskMode) {
        self.courseId = courseId
        self.type = type
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch type {
        case .CHECKBOX:
            let constructor = CreateCourseTaskConstructor(mode: mode, model: CreateCourseTaskModel())
            return CreateCourseTaskViewModel(courseId: courseId, type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TEXT:
            let constructor = CreateTextCourseTaskConstructor(mode: mode, model: CreateTextCourseTaskModel())
            return CreateTextCourseTaskViewModel(courseId: courseId, type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TIMER:
            let constructor = CreateTimerCourseTaskConstructor(mode: mode, model: CreateTimerCourseTaskModel())
            return CreateTimerCourseTaskViewModel(courseId: courseId, type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .RITUAL:
            let constructor = CreateRepeatCourseTaskConstructor(mode: mode, model: CreateRepeatCourseTaskModel())
            return CreateRepeatCourseTaskViewModel(courseId: courseId, type: type, constructor: constructor, mode: mode, taskRouter: router)
        }
    }
    
}

