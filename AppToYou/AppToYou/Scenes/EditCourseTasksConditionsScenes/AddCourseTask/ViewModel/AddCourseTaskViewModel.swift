import Foundation
import XCoordinator
import UIKit


protocol AddCourseTaskViewModelInput: TimePickerDelegate {
    func saveDidTapped()
    func loadFields()
}

protocol AddCourseTaskViewModelOutput: AnyObject {
    var sections: Observable<[TableViewSection]> { get }
    var updatedState: Observable<Void> { get }
}

protocol AddCourseTaskViewModel: AnyObject {
    var input: AddCourseTaskViewModelInput { get }
    var output: AddCourseTaskViewModelOutput { get }
}

extension AddCourseTaskViewModel where Self: AddCourseTaskViewModelInput & AddCourseTaskViewModelOutput {
    var input: AddCourseTaskViewModelInput { return self }
    var output: AddCourseTaskViewModelOutput { return self }
}


class AddCourseTaskViewModelImpl: AddCourseTaskViewModel, AddCourseTaskViewModelInput,
                                  AddCourseTaskViewModelOutput, AddCourseTaskDataSource, CreatorDelegate {
    
    static let activeDayCode = "1"
    static let timeSeparator: Character = ":"
    
    var sections: Observable<[TableViewSection]> = Observable([])
    
    var updatedState: Observable<Void> = Observable(Void())
    
    private let addTaskRouter: UnownedRouter<AddCourseTaskRoute>
    private let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let constructor: AddCourseTaskConstructor
    private let validator = ConfiguredCourseTaskValidator()
    
    private let courseTask: CourseTaskResponse
    
    private let configuredtaskModel: AddConfiguredCourseTaskModel
    
    init(courseTask: CourseTaskResponse, constructor: AddCourseTaskConstructor,addTaskRouter: UnownedRouter<AddCourseTaskRoute>) {
        self.courseTask = courseTask
        self.constructor = constructor
        self.addTaskRouter = addTaskRouter
        
        configuredtaskModel = AddConfiguredCourseTaskModel(courseId: courseTask.courseId, taskId: courseTask.identifier.id)
        loadFields()
    }
    
    func saveDidTapped() {
        guard validate() else {
            return
        }
        prepare()
        save()
    }
    
    func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }
    
    private func validate() -> Bool {
        validator.validate(model: constructor.model)
        return !validator.hasError
    }
    
    private func prepare() {
        configuredtaskModel.attribute = getUpdatedAttribute()
        configuredtaskModel.sanction = constructor.model.sanctionModel?.fieldModel.value
    }
    
    private func save() {
        courseService.addCourseTask(configuredtaskModel) { [weak self] result in
            switch result {
            case .success(let userTask):
                self?.addTaskRouter.trigger(.taskAdded)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?) {
        addTaskRouter.trigger(.timePicker)
    }
    
    func showSanctionQuestion() {
        addTaskRouter.trigger(.sanctionQuestion)
    }
    
    func userTaskdurationPicked(_ duration: DurationTime) {
        guard let durationField = constructor.model.fieldModel as? TaskDurationCellModel else {
            return
        }
        durationField.durationModel.update(durationTime: duration)
        update()
    }
    
    func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    func getTitleModel() -> AddTaskTitleModel {
        let title = courseTask.taskName
        let subtitle = getSubtitle()
        let icon = geTitleIcon()
        return AddTaskTitleModel(title: title, subtitle: subtitle, icon: icon)
    }
    
    
    func getDescription() -> String? {
        return courseTask.taskDescription
    }
    
    func getAttributeTitle() -> String {
        return getTaskAttributeTitle()
    }
    
    func getField() -> AnyObject? {
        return getTaskField()
    }
    
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool) {
        let min = courseTask.minSanction ?? .zero
        let isEnabled = min > .zero
        let field = NaturalNumberFieldModel(value: courseTask.taskSanction)
        return (field, min, isEnabled)
    }
    
    private func getSubtitle() -> String {
        var title = String()
        
        switch courseTask.frequencyType {
        case .ONCE:
            title = R.string.localizable.once()
        case .EVERYDAY:
            title = R.string.localizable.daily()
        case .WEEKDAYS:
            title = R.string.localizable.onWeekdays()
        case .MONTHLY:
            title = R.string.localizable.monthly()
        case .YEARLY:
            title = R.string.localizable.everyYear()
        case .CERTAIN_DAYS:
            title = getWeekdaysModels()
                .filter { $0.isSelected }
                .map { $0.title }
                .joined(separator: ", ")
        }
        
        return title
    }
    
    private func getWeekdaysModels() -> [WeekdayModel] {
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        let models = orderedSymbols.map { WeekdayModel(title: $0) }
        
        if let daysCode = courseTask.daysCode {
            let codeArray = Array(daysCode)
            zip(models, codeArray).forEach { item in
                let isSelected = String(item.1) == Self.activeDayCode
                item.0.chandeSelectedState(isSelected)
            }
        }
        return models
    }
    
    private func getTaskAttributeTitle() -> String {
        switch courseTask.taskType {
        case .CHECKBOX:
            return String()
        case .TEXT:
            return "Выберите оптимальное для вас количество символов для выполнения задачи"
        case .TIMER:
            return "Выберите оптимальную для вас длительность выполнения задачи"
        case .RITUAL:
            return "Выберите оптимальное для вас количество повторений выполнения задачи"
        }
    }
    
    private func getTaskField() -> AnyObject? {
        let attribute = courseTask.taskAttribute ?? String()
        let isEditable = courseTask.editable ?? false
        var field: AnyObject? = nil
        
        switch courseTask.taskType {
        case .CHECKBOX:
            break
            
        case .TEXT:
            let minSymbols = Int(attribute) ?? .zero
            let numberField = NaturalNumberFieldModel(value: minSymbols)
            let model = MinimumSymbolsModel(fieldModel: numberField, lockModel: nil)
            model.updateActiveState(isEditable)
            model.updateStyle(StyleManager.reversedcolorsTextField)
            field = model
            
        case .TIMER:
            let hour = TimeBlockModelFactory.getHourModel()
            let min = TimeBlockModelFactory.getMinModel()
            let sec = TimeBlockModelFactory.getSecModel()
            let duration = TaskDurationModel(hourModel: hour, minModel: min, secModel: sec)

            attribute.split(separator: Self.timeSeparator)
                .enumerated()
                .forEach { item in
                    let value = String(item.element)

                    switch item.offset {
                    case 0: hour.update(value: value)
                    case 1: min.update(value: value)
                    case 2: sec.update(value: value)
                    default: break
                    }
                }
            
            let model = TaskDurationCellModel(durationModel: duration, lockModel: nil, timerCallback: { [weak self] in
                self?.showTimePicker(pickerType: .userTaskDuration, delegate: nil)
            })
            model.updateStyle(StyleManager.reversedcolorsTextField)
            model.updateActiveState(isEditable)
            field = model
            
        case .RITUAL:
            let count = Int(attribute) ?? .zero
            let field = NaturalNumberFieldModel(value: count)
            let model = RepeatCounterModel(valueModel: field, lockModel: nil)
            model.updateStyle(StyleManager.reversedcolorsTextField)
            model.updateActiveState(isEditable)
        }
        return field
    }
    
    private func getUpdatedAttribute() -> String? {
        switch courseTask.taskType {
        case .CHECKBOX:
            return nil
            
        case .TEXT:
            guard let model = constructor.model.fieldModel as? MinimumSymbolsModel else {
                return nil
            }
            let minSymbols = model.fieldModel.value
            return String(minSymbols)
            
        case .TIMER:
            guard let model = constructor.model.fieldModel as? TaskDurationCellModel else {
                return nil
            }
            let h = model.durationModel.hourModel
            let m = model.durationModel.minModel
            let s = model.durationModel.secModel
            let separator = Self.timeSeparator
            return "\(h.value)\(separator)\(m.value)\(separator)\(s.value)"
            
        case .RITUAL:
            guard let model = constructor.model.fieldModel as? RepeatCounterModel else {
                return nil
            }
            let count = model.valueModel.value
            return String(count)
        }
    }
    
    private func geTitleIcon() -> UIImage? {
        var icon: UIImage? = nil
        
        switch courseTask.taskType {
        case .CHECKBOX: icon = R.image.checkBoxWithoutBackground()
        case .TEXT: icon = R.image.text()
        case .TIMER: icon = R.image.timer()
        case .RITUAL:
            let count = courseTask.taskAttribute ?? "0"
            icon = count.image(withAttributes: [.font: UIFont.systemFont(ofSize: 24)])
        }
        
        return icon?.withRenderingMode(.alwaysTemplate)
    }
    
}
