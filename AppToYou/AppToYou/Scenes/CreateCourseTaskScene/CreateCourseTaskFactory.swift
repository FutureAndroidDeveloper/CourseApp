import Foundation
import XCoordinator


class CreateCourseTaskFactory {
    private let type: ATYTaskType
    private let mode: CreateTaskMode
    
    init(type: ATYTaskType, mode: CreateTaskMode) {
        self.type = type
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch type {
        case .CHECKBOX:
            let constructor = CreateCourseTaskConstructor(mode: mode, model: CreateCourseTaskModel())
            return CreateCourseTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TEXT:
            let constructor = CreateTextCourseTaskConstructor(mode: mode, model: CreateTextCourseTaskModel())
            return CreateTextCourseTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .TIMER:
            let constructor = CreateTimerCourseTaskConstructor(mode: mode, model: CreateTimerCourseTaskModel())
            return CreateTimerCourseTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
            
        case .RITUAL:
            let constructor = CreateRepeatCourseTaskConstructor(mode: mode, model: CreateRepeatCourseTaskModel())
            return CreateRepeatCourseTaskViewModel(type: type, constructor: constructor, mode: mode, taskRouter: router)
        }
    }
    
}

