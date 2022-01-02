//import Foundation
//import XCoordinator
//
//
//class TimerCreateTaskViewModel: DefaultCreateTaskViewModel<TimerCreateTaskModel>, TimerTaskCreationDelegate {
//    
//    private struct Constants {
//        static let timeSeparator: Character = ":"
//    }
//    
//    private lazy var constructor: TimerTaskModel = {
//        return TimerTaskModel(mode: mode, delegate: self)
//    }()
//    
//    private let validator = TimerTaskValidator()
//    
//    
//    override func saveDidTapped() {
//        guard validate(model: constructor.model) else {
//            return
//        }
//        save()
//    }
//    
//    override func validate(model: TimerCreateTaskModel) -> Bool {
//        let baseValidationResult = super.validate(model: model)
//        
//        validator.validate(model: model)
//        if !validator.hasError {
//            prepare(model: model)
//        }
//        return !validator.hasError && baseValidationResult
//    }
//    
//    override func prepare(model: TimerCreateTaskModel) {
//        super.prepare(model: model)
//        
//        let duration = constructor.model.durationModel.durationModel
//        let h = duration.hourModel.value
//        let m = duration.minModel.value
//        let s = duration.secModel.value
//        let separator = Constants.timeSeparator
//        userTaskRequest?.taskAttribute = "\(h)\(separator)\(m)\(separator)\(s)"
//    }
//    
//    override func userTaskdurationPicked(_ duration: DurationTime) {
//        constructor.model.durationModel.durationModel.update(durationTime: duration)
//        update()
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
//    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?) {
//        let attribute = userTask?.taskAttribute ?? String()
//        let hour = TimeBlockModelFactory.getHourModel()
//        let min = TimeBlockModelFactory.getMinModel()
//        let sec = TimeBlockModelFactory.getSecModel()
//        
//        attribute.split(separator: Constants.timeSeparator)
//            .enumerated()
//            .forEach { item in
//                let value = String(item.element)
//                
//                switch item.offset {
//                case 0: hour.update(value: value)
//                case 1: min.update(value: value)
//                case 2: sec.update(value: value)
//                default: break
//                }
//            }
//        
//        let duration = TaskDurationModel(hourModel: hour, minModel: min, secModel: sec)
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
//        return (duration, lockModel)
//    }
//    
//}
