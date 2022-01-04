import Foundation
import XCoordinator


class AdminEditCourseTaskViewModel: CreateCourseTaskViewModel, AdminEditCourseTaskDataSourse {
    
    private let constructor: AdminEditCourseTaskConstructor
    
    let courseTask: CourseTaskResponse
    private let courseName: String
     
    
    init(courseName: String, courseTask: CourseTaskResponse, constructor: AdminEditCourseTaskConstructor,
         mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.courseName = courseName
        self.courseTask = courseTask
        self.constructor = constructor
        super.init(
            courseId: courseTask.courseId, type: courseTask.taskType,
            constructor: constructor, mode: mode, taskRouter: taskRouter)
    }
    
    override func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }
    
    override func saveDidTapped() {
        guard validate(model: constructor.courseTaskModel) else {
            return
        }
        prepare(model: constructor.checkboxModel)
        save()
    }
    
    override func save() {
        let id = courseTask.identifier.id
        courseService.remove(taskId: id) { [weak self] result in
            switch result {
            case .success:
                self?.updateTask()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateTask() {
        super.save()
    }
    
    override func getNameModel() -> TextFieldModel {
        let model = super.getNameModel()
        let name = courseTask.taskName
        model.update(value: name)
        return model
    }
    
    override func getFrequncy() -> FrequncyValueModel {
        let model = super.getFrequncy()
        let frequency = courseTask.frequencyType
        model.update(frequency)
        return model
    }
    
    override func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let (model, _, _) = super.getSanctionModel()
        let sanction = courseTask.taskSanction
        let minValue = courseTask.minSanction ?? 0
        model.update(value: sanction)
        
        return (model, minValue, sanction > .zero)
    }
    
    override func getWeekdayModels() -> [WeekdayModel] {
        let models = super.getWeekdayModels()
        
        if let daysCode = courseTask.daysCode {
            let codeArray = Array(daysCode)
            zip(models, codeArray).forEach { item in
                let isSelected = String(item.1) == Self.activeDayCode
                item.0.chandeSelectedState(isSelected)
            }
        }
        return models
    }
    
    override func getMinCourseSanctionModel() -> NaturalNumberFieldModel {
        let model = super.getMinCourseSanctionModel()
        model.update(value: courseTask.minSanction ?? 0)
        return model
    }
    
    override func getCourseTaskDurationModel() -> (duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel) {
        let (durationModel, isInfiniteModel) = super.getCourseTaskDurationModel()
        
        if let duration = courseTask.duration {
            let time = DurationTime(hour: "\(duration.year)", min: "\(duration.month)", sec: "\(duration.day)")
            durationModel.update(durationTime: time)
        }
        isInfiniteModel.chandeSelectedState(courseTask.infiniteExecution)
        return (durationModel, isInfiniteModel)
    }
    
    func getCourseName() -> String {
        return courseName
    }
}
