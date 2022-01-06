import Foundation
import XCoordinator


class UserEditTextCourseTaskViewModel: UserEditCourseTaskViewModel, TextTaskDataSource {
    
    private let constructor: UserEditTextCourseTaskConstructor
    private let validator = TextTaskValidator()
    
    init(userTask: UserTaskResponse, constructor: UserEditTextCourseTaskConstructor, mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        self.constructor = constructor
        super.init(userTask: userTask, constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setTextDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }

    override func saveDidTapped() {
        guard validate(model: constructor.userEditTextTaskModel) else {
            return
        }
        prepare(model: constructor.userEditTextTaskModel)
        save()
    }

    func validate(model: TextCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }

    func prepare(model: UserEditTextCourseTaskModel) {
        super.prepare(model: model)
        
        let description = model.textModel.descriptionModel.fieldModel.value
        let minSymbols = model.textModel.lengthLimitModel.fieldModel.value
        updateUserTaskRequest?.taskDescription = description
        updateUserTaskRequest?.taskAttribute = "\(minSymbols)"
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        let description = userTask.taskDescription
        return PlaceholderTextViewModel(value: description, placeholder: "Например, положительные моменты")
    }
    
    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = userTask.taskAttribute ?? String()
        let minSymbols = Int(attribute) ?? 0
        let lockModel = LockButtonModel(isLocked: userTask.editableCourseTask)
        let sybmolsModel = NaturalNumberFieldModel(value: minSymbols)
        
        return (sybmolsModel, lockModel)
    }
    
}

