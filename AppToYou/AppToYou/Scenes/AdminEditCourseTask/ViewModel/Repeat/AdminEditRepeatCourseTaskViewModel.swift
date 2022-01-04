import Foundation
import XCoordinator


class AdminEditRepeatCourseTaskViewModel: AdminEditCourseTaskViewModel, CounterTaskDataSource {
    private let constructor: AdminEditRepeatCourseTaskConstructor
    private let repeatViewModel: AdminEditRepeatCourseTask
    
    
    init(courseName: String, courseTask: CourseTaskResponse,
         constructor: AdminEditRepeatCourseTaskConstructor,
         mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.constructor = constructor
        self.repeatViewModel = AdminEditRepeatCourseTask(type: courseTask.taskType, constructor: constructor,
                                                         mode: mode, taskRouter: taskRouter)
        super.init(courseName: courseName, courseTask: courseTask, constructor: constructor,
                   mode: mode, taskRouter: taskRouter)
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        repeatViewModel.setDataSource(dataSource: self)
        repeatViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.repeatCourseTaskModel) else {
            return
        }
        prepare(model: constructor.repeatCourseTaskModel)
        save()
    }

    func validate(model: AdminEditRepeatCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = repeatViewModel.validate(model: model.repeatModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: AdminEditRepeatCourseTaskModel) {
        super.prepare(model: model)
        
        if let isLocked = model.repeatModel.countModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
        let repeatCount = model.repeatModel.countModel.valueModel.value
        courseTaskRequest?.taskAttribute = "\(repeatCount)"
    }
    
    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let fieldModel = NaturalNumberFieldModel()
        
        if let attribute = courseTask.taskAttribute, let count = Int(attribute) {
            fieldModel.update(value: count)
        }
        let editable = courseTask.editable ?? true
        let lockModel = LockButtonModel(isLocked: !editable)
        
        return (fieldModel, lockModel)
    }
}
