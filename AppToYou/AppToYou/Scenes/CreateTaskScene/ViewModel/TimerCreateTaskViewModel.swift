import Foundation
import XCoordinator


class TimerCreateTaskViewModel: DefaultCreateTaskViewModel<TimerCreateTaskModel>, TimerTaskCreationDelegate {
    
    private lazy var constructor: TimerTaskModel = {
        return TimerTaskModel(delegate: self)
    }()
    
    private let validator = TimerTaskValidator()
    
    
    override func saveDidTapped() {
        guard validate(model: constructor.model) else {
            return
        }
        save()
    }
    
    override func validate(model: TimerCreateTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        
        validator.validate(model: model)
        if !validator.hasError {
            prepare(model: model)
        }
        return !validator.hasError && baseValidationResult
    }
    
    override func prepare(model: TimerCreateTaskModel) {
        super.prepare(model: model)
        
        let duration = constructor.model.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value        
        taskRequest?.taskAttribute = "\(h):\(m):\(s)"
    }
    
    override func durationPicked(_ duration: DurationTime) {
        constructor.model.durationModel.durationModel.update(durationTime: duration)
        update()
    }
    
    override func update() {
        data.value = constructor.getModels()
    }
    
    func getDurationModel() -> TaskDurationModel {
        // TODO: - получать длительность из модели задачи
        
        let model = TaskDurationModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                      minModel: TimeBlockModelFactory.getMinModel(),
                                      secModel: TimeBlockModelFactory.getSecModel())
        return model
    }
    
}
