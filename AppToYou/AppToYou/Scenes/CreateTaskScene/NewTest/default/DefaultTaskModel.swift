import Foundation


protocol DefaultTaskCreationDataSource: AnyObject {
    func getNameModel() -> TextFieldModel
    func getFrequncy() -> FrequncyValueModel
    func getOnceDateModel() -> DateFieldModel
    func getWeekdayModels() -> [WeekdayModel]
    func getPeriodModel() -> TaskPeriodModel
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool)
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool)
    func getMinCourseSanctionModel() -> NaturalNumberFieldModel
    func getCourseName() -> String
    func getCourseTaskDurationModel() -> (duration: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel)
}

protocol DefaultTaskCreationDelegate: DefaultTaskCreationDataSource {
    func update()
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
}

enum CreateTaskMode {
    case createUserTask
    case createCourseTask
    
    case editUserTask
    case editCourseTask
    
    case adminEditCourseTask
}

class DefaultTaskModel<DataModel: DefaultCreateTaskModel, DataProvider>: TaskCreation where DataProvider: DefaultTaskCreationDelegate {
    
    var model: DataModel
    weak var delegate: DataProvider?
    
    let mode: CreateTaskMode
    
    init(mode: CreateTaskMode, delegate: DataProvider) {
        self.mode = mode
        self.delegate = delegate
        model = DataModel()
        construct()
    }
    
    func construct() {
        guard let dataProvider = delegate else {
            return
        }
        
        addName(dataProvider)
        addFrequency(dataProvider)
        addNotificationHandler(dataProvider)
        addSanction(dataProvider)
        addDuration(dataProvider)
        
        switch mode {
        case .createUserTask, .editUserTask:
            break
            
        case .createCourseTask:
            model.addLockHeaderModel()
            addMinSanctionModel(dataProvider)
            
        case .editCourseTask:
            addCourseNameModel(dataProvider)
            
            model.nameModel.isEditable = false
            model.periodModel?.isEditable = false
            
        case .adminEditCourseTask:
            model.addLockHeaderModel()
            addMinSanctionModel(dataProvider)
            addCourseNameModel(dataProvider)
        }
    }
    
    private func addDuration(_ dataProvider: DefaultTaskCreationDelegate) {
        switch mode {
        case .createUserTask, .editUserTask, .editCourseTask:
            addPeriod(dataProvider)
        default:
            addCourseTaskDuration(dataProvider)
        }
    }
    
    func getModels() -> [AnyObject] {
        return model.prepare()
    }
    
    private func addName(_ dataProvider: DefaultTaskCreationDelegate) {
        let nameModel = dataProvider.getNameModel()
        model.addName(model: nameModel)
    }
    
    private func addFrequency(_ dataProvider: DefaultTaskCreationDelegate) {
        let frequencyValue = dataProvider.getFrequncy()
        
        model.addFrequency(frequencyValue, mode: mode) { [weak self] frequency in
            self?.model.removeWeekdayHandler()
            self?.model.removeSelectDateHandler()
            self?.addDuration(dataProvider)
            
            if frequency == .ONCE {
                self?.addselectDate(dataProvider)
                self?.model.removePeriodHandler()
            }
            else if frequency == .CERTAIN_DAYS {
                self?.addWeekdayHandler(dataProvider)
            }
            
            self?.delegate?.update()
        }
    }
    
    private func addPeriod(_ dataProvider: DefaultTaskCreationDelegate) {
        let periodModel = dataProvider.getPeriodModel()
        model.removePeriodHandler()
        model.addPeriodHandler(isInfiniteModel: periodModel.isInfiniteModel, start: periodModel.start, end: periodModel.end)
    }
    
    private func addNotificationHandler(_ dataProvider: DefaultTaskCreationDelegate) {
        let (models, isEnabled) = dataProvider.getNotificationModels()
        
        model.addNotificationHandler(notificationModels: models, isEnabled: isEnabled) { [weak self] notificationDelegate in
            self?.delegate?.showTimePicker(pickerType: .notification, delegate: notificationDelegate)
        }
    }
    
    private func addSanction(_ dataProvider: DefaultTaskCreationDelegate) {
        let (sanctionModel, min, isEnabled) = dataProvider.getSanctionModel()
        
        model.addSanction(
            model: sanctionModel, isEnabled: isEnabled, minValue: min,
            switchChanged: { [weak self] isOn in
                self?.model.minSanctionModel?.didActivate?(isOn)
            }, questionCallback: { [weak self] in
                print("Question")
            })
    }
    
    private func addMinSanctionModel(_ dataProvider: DefaultTaskCreationDelegate) {
        let minSanctionModel = dataProvider.getMinCourseSanctionModel()
        model.addCourseMinSanction(model: minSanctionModel)
    }
    
    private func addselectDate(_ dataProvider: DefaultTaskCreationDelegate) {
        let onceDate = dataProvider.getOnceDateModel()
        model.addSelectDateHandler(date: onceDate)
    }
    
    private func addWeekdayHandler(_ dataProvider: DefaultTaskCreationDelegate) {
        let weekdayModels = dataProvider.getWeekdayModels()
        model.addWeekdayHandler(models: weekdayModels)
    }
    
    private func addCourseNameModel(_ dataProvider: DefaultTaskCreationDelegate) {
        let name = dataProvider.getCourseName()
        model.addCourseNameModel(name: name)
    }
    
    private func addCourseTaskDuration(_ dataProvider: DefaultTaskCreationDelegate) {
        let (durationModel, isInfinite) = dataProvider.getCourseTaskDurationModel()
        model.addCourseTaskDurationHandler(duration: durationModel, isInfiniteModel: isInfinite, timerCallback: { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .courseTaskDuration, delegate: nil)
            
        })
    }
    
    func getModel() -> DefaultCreateTaskModel {
        return model
    }
    
}
