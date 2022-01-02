//import Foundation
//import XCoordinator
//
//
//class TextCreateTaskViewModel: DefaultCreateTaskViewModel<TextCreateTaskModel>, TextTaskCreationDelegate {
//
//    private lazy var constructor: TextTaskModel = {
//        return TextTaskModel(mode: mode, delegate: self)
//    }()
//    
//    private let validator = TextTaskValidator()
//    
//    
//    override func saveDidTapped() {
//        guard validate(model: constructor.model) else {
//            return
//        }
//        save()
//    }
//    
//    override func validate(model: TextCreateTaskModel) -> Bool {
//        let baseValidationResult = super.validate(model: model)
//        
//        validator.validate(model: model)
//        if !validator.hasError {
//            prepare(model: model)
//        }
//        return !validator.hasError && baseValidationResult
//    }
//    
//    override func prepare(model: TextCreateTaskModel) {
//        super.prepare(model: model)
//        
//        let description = constructor.model.descriptionModel.fieldModel.value
//        let minSymbols = constructor.model.lengthLimitModel.fieldModel.value
//        userTaskRequest?.taskDescription = description
//        userTaskRequest?.taskAttribute = "\(minSymbols)"
//    }
//    
//    override func courseTaskDurationPicked(_ duration: Duration) {
//        let time = DurationTime(hour: "\(duration.year)", min: "\(duration.month)", sec: "\(duration.day)")
//        constructor.model.courseTaskDurationModel?.durationModel.update(durationTime: time)
//        update()
//    }
//    
//    override func update() {
//        let models = constructor.getModels()
//        let section = TableViewSection(models: models)
//        sections.value = [section]
//    }
//    
//    func getDescriptionModel() -> PlaceholderTextViewModel {
//        let description = userTask?.taskDescription
//        return PlaceholderTextViewModel(value: description, placeholder: "Например, положительные моменты")
//    }
//    
//    func getMinSymbolsModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
//        let minSanction = userTask?.minimumCourseTaskSanction ?? 0
//        var lockModel: LockButtonModel?
//        
//        switch mode {
//        case .createCourseTask, .adminEditCourseTask:
//            let isLoced = userTask?.editableCourseTask ?? false
//            lockModel = LockButtonModel(isLocked: isLoced, stateChanged: { isLocked in
//                print("LOCK tapped = \(isLoced)")
//            })
//            
//        default:
//            break
//        }
//        
//        return (NaturalNumberFieldModel(value: minSanction), lockModel)
//    }
//    
//}
