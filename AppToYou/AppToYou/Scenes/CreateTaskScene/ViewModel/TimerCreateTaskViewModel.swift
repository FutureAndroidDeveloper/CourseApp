import Foundation
import XCoordinator


class TimerCreateTaskViewModel: DefaultCreateTaskViewModel, TimerTaskCreationDelegate {
    
    private lazy var constructor: TimerTaskModel = {
        return TimerTaskModel(delegate: self)
    }()
    
    override func durationTimePicked(_ time: DurationTime) {
//        let duration =  TaskDurationModel(durationTime: time)
        constructor.model.durationModel.durationModel.update(durationTime: time)
        update()
    }
    
    override func update() {
        data.value = constructor.getModels()
    }
    
    override func saveDidTapped() {
        super.saveDidTapped()
        
        let duration = constructor.model.durationModel.durationModel
        let h = duration.hourModel.value
        let m = duration.minModel.value
        let s = duration.secModel.value
        print()
        print("duration = \(h):\(m):\(s)")
    }
    
    func getDurationModel() -> TaskDurationModel {
        // TODO: - получать длительность из модели задачи
        
        let model = TaskDurationModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                      minModel: TimeBlockModelFactory.getMinModel(),
                                      secModel: TimeBlockModelFactory.getSecModel())
        return model
    }
    
}
