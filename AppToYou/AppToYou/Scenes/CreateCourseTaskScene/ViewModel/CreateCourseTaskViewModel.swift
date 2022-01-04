import Foundation
import XCoordinator


class CreateCourseTaskViewModel: CreateUserTaskViewModel, CreateCourseTaskDataSourse {
    
    private let constructor: CreateCourseTaskConstructor
    private let validator = CreateCourseTaskValidator()
    let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    
    private let courseId: Int
    var courseTaskRequest: CourseTaskCreateRequest?
    
    init(courseId: Int, type: ATYTaskType, constructor: CreateCourseTaskConstructor,
         mode: CreateTaskMode, taskRouter: UnownedRouter<TaskRoute>) {
        
        self.courseId = courseId
        self.constructor = constructor
        super.init(type: type, constructor: constructor, mode: mode, taskRouter: taskRouter)
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
        prepare(model: constructor.courseTaskModel)
        save()
    }
    
    func validate(model: CreateCourseTaskModel) -> Bool {
        let baseValidationResult = super.validate(model: model)
        validator.validate(model: model)
        
        return !validator.hasError && baseValidationResult
    }
    
    func prepare(model: CreateCourseTaskModel) {
        let name = model.nameModel.fieldModel.value
        let freq = model.frequencyModel.value.frequency
        let sanction = model.sanctionModel.fieldModel.value
        let isInfinite = model.courseTaskDurationModel?.isInfiniteModel.isSelected ?? false
        let minSanction = model.minSanctionModel?.fieldModel.value == .zero ? nil : model.minSanctionModel?.fieldModel.value
        let duration = model.courseTaskDurationModel?.durationModel.getDurationModel()
        let daysCode = model.weekdayModel?.weekdayModels
            .map { $0.isSelected ? Self.activeDayCode : Self.inactiveDayCode }
            .joined()
        
        courseTaskRequest = CourseTaskCreateRequest.init(
            taskName: name, taskType: type, frequencyType: freq, taskSanction: sanction,
            infiniteExecution: isInfinite, duration: duration, editable: nil, minSanction: minSanction, daysCode: daysCode)
        
    }
    
    override func save() {
        guard let courseTask = courseTaskRequest else {
            return
        }
        
        courseService.create(task: courseTask, id: courseId) { [weak self] result in
            switch result {
            case .success(let newTask):
                print(newTask)
                self?.taskRouter.trigger(.done)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func courseTaskDurationPicked(_ duration: Duration) {
        let time = DurationTime(hour: "\(duration.year)", min: "\(duration.month)", sec: "\(duration.day)")
        constructor.courseTaskModel.courseTaskDurationModel?.durationModel.update(durationTime: time)
        update()
    }
    
    func getMinCourseSanctionModel() -> NaturalNumberFieldModel {
        return NaturalNumberFieldModel()
    }
    
    func getCourseTaskDurationModel() -> (duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel) {
        let year = TimeBlockModel(unit: "год")
        let month = TimeBlockModel(unit: "мес")
        let day = TimeBlockModel(unit: "дн")
        let duration = TaskDurationModel(hourModel: year, minModel: month, secModel: day)
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечное выполнение", isSelected: true)
        
        return (duration, isInfiniteModel)
    }
    
}
