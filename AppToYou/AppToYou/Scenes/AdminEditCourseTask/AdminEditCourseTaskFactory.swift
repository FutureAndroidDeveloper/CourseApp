import Foundation
import XCoordinator


class AdminEditCourseTaskFactory {
    private let courseName: String
    private let courseTask: CourseTaskResponse
    private let mode: CreateTaskMode
    
    init(courseName: String, courseTask: CourseTaskResponse, mode: CreateTaskMode) {
        self.courseName = courseName
        self.courseTask = courseTask
        self.mode = mode
    }
    
    func getViewModel(_ router: UnownedRouter<TaskRoute>) -> CreateTaskViewModel {
        
        switch courseTask.taskType {
        case .CHECKBOX:
            let constructor = AdminEditCourseTaskConstructor(mode: mode, model: AdminEditCourseTaskModel())
            return AdminEditCourseTaskViewModel(
                courseName: courseName, courseTask: courseTask,
                constructor: constructor, mode: mode, taskRouter: router
            )
            
        case .TEXT:
            let constructor = AdminEditTextCourseTaskConstructor(mode: mode, model: AdminEditTextCourseTaskModel())
            return AdminEditTextCourseTaskViewModel(
                courseName: courseName, courseTask: courseTask,
                constructor: constructor, mode: mode, taskRouter: router
            )
            
        case .TIMER:
            let constructor = AdminEditTimerCourseTaskConstructor(mode: mode, model: AdminEditTimerCourseTaskModel())
            return AdminEditTimerCourseTaskViewModel(
                courseName: courseName, courseTask: courseTask,
                constructor: constructor, mode: mode, taskRouter: router
            )
            
        case .RITUAL:
            let constructor = AdminEditRepeatCourseTaskConstructor(mode: mode, model: AdminEditRepeatCourseTaskModel())
            return AdminEditRepeatCourseTaskViewModel(
                courseName: courseName, courseTask: courseTask,
                constructor: constructor, mode: mode, taskRouter: router
            )
        }
    }
    
}
