import Foundation
import XCoordinator


class UserEditCourseTaskViewModel: EditUserTaskViewModel, EditCourseTaskDataSource {
    
    private let constructor: UserEditCourseTaskConstructor
    private let validator = UserEditCourseTaskValidator()
    
    init(task: Task, constructor: UserEditCourseTaskConstructor, mode: CreateTaskMode,
         synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(task: task, constructor: constructor, mode: mode,
                   synchronizationService: synchronizationService, taskRouter: taskRouter)
    }
    
    override func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
        
        constructor.setEnableStateForFields()
        updateState()
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        constructor.setConstructorDataSource(dataSource: self)
        constructor.construct()
        update()
    }

    override func validate(model: DefaultCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: constructor.userEditTaskModel)
        
        return !validator.hasError && baseValidationResult
    }
    
    override func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let (field, _, _) = super.getSanctionModel()
        
        let minSanction = task.minimumCourseTaskSanction ?? 0
        let taskSanction = task.taskSanction
        let sanction = max(taskSanction, minSanction)
        let isEnabled = sanction > .zero
        
        field.update(value: sanction)
        return (field, minSanction, isEnabled)
    }
    
    func getCourseName() -> String {
        return task.courseName ?? String()
    }
    
}
