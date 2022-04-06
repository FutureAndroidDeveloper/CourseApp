import Foundation
import XCoordinator


class AdminEditTextCourseTaskViewModel: AdminEditCourseTaskViewModel, TextTaskDataSource {
    private let constructor: AdminEditTextCourseTaskConstructor
    private let repeatViewModel: AdminEditTextCourseTask
    
    
    init(courseName: String, courseTask: CourseTaskResponse, constructor: AdminEditTextCourseTaskConstructor,
         mode: CreateTaskMode, synchronizationService: SynchronizationService, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.constructor = constructor
        self.repeatViewModel = AdminEditTextCourseTask(
            type: courseTask.taskType, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
        super.init(
            courseName: courseName, courseTask: courseTask, constructor: constructor, mode: mode,
            synchronizationService: synchronizationService, taskRouter: taskRouter
        )
    }
    
    override func loadFields() {
        constructor.setDelegate(delegate: self)
        constructor.setDataSource(dataSource: self)
        repeatViewModel.setDataSource(dataSource: self)
        repeatViewModel.loadFields()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.textCourseTaskModel) else {
            return
        }
        prepare(model: constructor.textCourseTaskModel)
        save()
    }

    func validate(model: AdminEditTextCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        let repeatResult = repeatViewModel.validate(model: model.textModel)
        
        return repeatResult && baseValidationResult
    }

    func prepare(model: AdminEditTextCourseTaskModel) {
        super.prepare(model: model)
        
        if let isLocked = model.textModel.lengthLimitModel.lockModel?.isLocked {
            courseTaskRequest?.editable = !isLocked
        }
        let minSymbols = model.textModel.lengthLimitModel.fieldModel.value
        courseTaskRequest?.taskAttribute = "\(minSymbols)"
        
        let description = model.textModel.descriptionModel.fieldModel.value
        courseTaskRequest?.taskDescription = description
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        let description = courseTask.taskDescription
        return PlaceholderTextViewModel(value: description, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = courseTask.taskAttribute ?? String()
        let minSymbols = Int(attribute) ?? 0
        let model = NaturalNumberFieldModel(value: minSymbols)
        
        let editable = courseTask.editable ?? true
        let lockModel = LockButtonModel(isLocked: !editable)
        return (model, lockModel)
    }
    
}
