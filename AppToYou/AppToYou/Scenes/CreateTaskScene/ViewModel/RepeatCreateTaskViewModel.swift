import Foundation
import XCoordinator


class RepeatCreateTaskViewModel: DefaultCreateTaskViewModel<RepeatCreateTaskModel>, CounterTaskCreationDelegate {
    
    private lazy var constructor: RepeatTaskModel = {
        return RepeatTaskModel(mode: mode, delegate: self)
    }()
    
    private let validator = RitualTaskValidator()
    
    
    override func saveDidTapped() {
        guard validate(model: constructor.model) else {
            return
        }
        save()
    }
    
    override func validate(model: RepeatCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        
        validator.validate(model: model)
        if !validator.hasError {
            prepare(model: model)
        }
        return !validator.hasError && baseValidationResult
    }
    
    override func prepare(model: RepeatCreateTaskModel) {
        super.prepare(model: model)
        
        let repeatCount = constructor.model.countModel.valueModel.value
        taskRequest?.taskAttribute = "\(repeatCount)"
    }
    
    override func courseTaskDurationPicked(_ duration: Duration) {
        let time = DurationTime(hour: "\(duration.year)", min: "\(duration.month)", sec: "\(duration.day)")
        constructor.model.courseTaskDurationModel?.durationModel.update(durationTime: time)
        update()
    }
    
    override func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func getCounterModel() -> (field: NaturalNumberFieldModel, lock: LockButtonModel?) {
        let attribute = task?.taskAttribute ?? String()
        let value = Int(attribute) ?? 0
        let fieldModel = NaturalNumberFieldModel(value: value)
        
        var lockModel: LockButtonModel?
        
        switch mode {
        case .createCourseTask, .adminEditCourseTask:
            let isLoced = task?.editableCourseTask ?? false
            lockModel = LockButtonModel(isLocked: isLoced, stateChanged: { isLocked in
                print("LOCK tapped = \(isLoced)")
            })
            
        default:
            break
        }
        
        return (fieldModel, lockModel)
    }
    
}
