import Foundation

enum CreateTaskMode {
    case createUserTask
    case createCourseTask(courseId: Int)
    
    case editUserTask(task: Task)
    case editCourseTask(task: Task)
    
    case adminEditCourseTask(courseName: String, task: CourseTaskResponse)
}


protocol CheckboxTaskDataSource: AnyObject {
    func getNameModel() -> TextFieldModel
    func getFrequncy() -> FrequncyValueModel
    func getOnceDateModel() -> DateFieldModel
    func getWeekdayModels() -> [WeekdayModel]
    func getPeriodModel() -> TaskPeriodModel
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool)
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool)
}

protocol CreatorDelegate: AnyObject {
    func update()
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
    func showSanctionQuestion()
}


class CheckboxTaskConstructor {
    
    let mode: CreateTaskMode
    let checkboxModel: DefaultCreateTaskModel
    
    weak var delegate: CreatorDelegate?
    private weak var dataSource: CheckboxTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: DefaultCreateTaskModel) {
        self.checkboxModel = model
        self.mode = mode
    }
    
    func setDataSource(dataSource: CheckboxTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    func setDelegate(delegate: CreatorDelegate?) {
        self.delegate = delegate
    }
    
    func construct() {
        guard let dataSource = dataSource else {
            return
        }
        
        addName(dataSource)
        addFrequency(dataSource)
        addNotificationHandler(dataSource)
        addSanction(dataSource)
    }
    
    func setEnableStateForFields() {
        checkboxModel.weekdayModel?.updateActiveState(false)
        checkboxModel.periodModel?.updateActiveState(false)
    }
    
    func getModels() -> [AnyObject] {
        return checkboxModel.prepare()
    }
    
    private func addName(_ dataProvider: CheckboxTaskDataSource) {
        let nameModel = dataProvider.getNameModel()
        checkboxModel.addName(model: nameModel)
    }
    
    private func addFrequency(_ dataProvider: CheckboxTaskDataSource) {
        let frequencyValue = dataProvider.getFrequncy()
        
        checkboxModel.addFrequency(frequencyValue, mode: mode) { [weak self] frequency in
            self?.checkboxModel.removeWeekdayHandler()
            self?.checkboxModel.removeSelectDateHandler()
            self?.addPeriod(dataProvider)
            
            if frequency == .ONCE {
                self?.addselectDate(dataProvider)
                self?.checkboxModel.removePeriodHandler()
            }
            else if frequency == .CERTAIN_DAYS {
                self?.addWeekdayHandler(dataProvider)
            }
            
            self?.delegate?.update()
        }
    }
    
    private func addPeriod(_ dataProvider: CheckboxTaskDataSource) {
        let periodModel = dataProvider.getPeriodModel()
        checkboxModel.removePeriodHandler()
        checkboxModel.addPeriodHandler(isInfiniteModel: periodModel.isInfiniteModel, start: periodModel.start, end: periodModel.end)
    }
    
    private func addNotificationHandler(_ dataProvider: CheckboxTaskDataSource) {
        let (models, isEnabled) = dataProvider.getNotificationModels()
        
        checkboxModel.addNotificationHandler(notificationModels: models, isEnabled: isEnabled) { [weak self] notificationDelegate in
            self?.delegate?.showTimePicker(pickerType: .notification, delegate: notificationDelegate)
        }
    }
    
    private func addSanction(_ dataProvider: CheckboxTaskDataSource) {
        let (sanctionModel, min, isEnabled) = dataProvider.getSanctionModel()
        
        checkboxModel.addSanction(
            model: sanctionModel, isEnabled: isEnabled, minValue: min,
            switchChanged: { [weak self] isOn in
                // TODO - 
//                self?.checkboxModel.minSanctionModel?.didActivate?(isOn)
            }, questionCallback: { [weak self] in
                self?.delegate?.showSanctionQuestion()
            })
    }
    
    private func addselectDate(_ dataProvider: CheckboxTaskDataSource) {
        let onceDate = dataProvider.getOnceDateModel()
        checkboxModel.addSelectDateHandler(date: onceDate)
    }
    
    private func addWeekdayHandler(_ dataProvider: CheckboxTaskDataSource) {
        let weekdayModels = dataProvider.getWeekdayModels()
        checkboxModel.addWeekdayHandler(models: weekdayModels)
    }
    
}
