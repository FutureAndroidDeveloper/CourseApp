import Foundation


protocol TaskCreationDelegate: AnyObject {
    func update()
    
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
    
    func getNameModel() -> TextFieldModel
    
    func getFrequncy() -> ATYFrequencyTypeEnum
    func getOnceDateModel() -> DateFieldModel
    func getPeriodModel() -> TaskPeriodModel
    func getDescriptionModel() -> PlaceholderTextViewModel
    func getMinSymbolsModel() -> NaturalNumberFieldModel
    func getDurationModel() -> TaskDurationModel
    func getNotificationModels() -> [NotificationTaskTimeModel]
    func getWeekdayModels() -> [WeekdayModel]
}

class TaskCreationModel {
    
    private var task: ATYUserTask
    private var type: ATYTaskType
    
    private weak var delegate: TaskCreationDelegate?
    
    private(set) var model: DefaultCreateTaskModel?
    
    init(type: ATYTaskType, delegate: TaskCreationDelegate? = nil) {
        self.type = type
        self.task = ATYUserTask()
        self.delegate = delegate
        task.taskType = type
        construct()
    }
    
    private func construct() {
        guard let dataProvider = delegate else {
            return
        }
        
        switch type {
        case .CHECKBOX:
            model = DefaultCreateTaskModel()
            
        case .TEXT:
            let textModel = TextCreateTaskModel()
            model = textModel
            addDescription()
            addLimit()
            
        case .TIMER:
            let timerModel = TimerCreateTaskModel()
            model = timerModel
            addDuration()
            
        case .RITUAL:
            let repeatModel = RepeatCreateTaskModel()
            repeatModel.addCountHandler()
            model = repeatModel
        }
        
        let nameModel = dataProvider.getNameModel()
        model?.addNameHandler(nameModel)
        
        let frequency = dataProvider.getFrequncy()
        addFrequency(initial: frequency)
        
        updatePeriod()
        addNotificationHandler()
                
        model?.addSanctionHandler(callbackText: { sanction in
            print(sanction)
//            self.task.taskSanction = Int(sanction) ?? -1
        }, questionCallback: {
            print("Question Handler")
        })
    }
    
    private func addselectDate() {
        guard let dataProvider = delegate else {
            return
        }
        
        let onceDate = dataProvider.getOnceDateModel()
        model?.addSelectDateHandler(date: onceDate)
    }
    
    private func addFrequency(initial frequency: ATYFrequencyTypeEnum) {
        
        model?.addFrequency(frequency) { [weak self] newFrequency in
            if frequency == newFrequency {
                return
            }
            print(newFrequency)
            
            if newFrequency != .ONCE || newFrequency != .CERTAIN_DAYS {
                print("1")
                self?.model?.removeWeekdayHandler()
                self?.model?.removeSelectDateHandler()
                self?.updatePeriod()
            }
            
            if newFrequency == .ONCE {
                self?.addselectDate()
                self?.model?.removePeriodHandler()
            }
            
            if newFrequency == .CERTAIN_DAYS {
                self?.addWeekdayHandler()
            }
            
            self?.addFrequency(initial: newFrequency)
            self?.delegate?.update()
        }
    }
    
    private func updatePeriod() {
        guard let dataProvider = delegate else {
            return
        }
        
        let periodModel = dataProvider.getPeriodModel()
        model?.removePeriodHandler()
        model?.addPeriodHandler(isInfiniteModel: periodModel.isInfiniteModel, start: periodModel.start, end: periodModel.end)
    }
    
    private func addDescription() {
        guard
            let textModel = model as? TextCreateTaskModel,
            let dataProvider = delegate
        else {
            return
        }
        
        let descriptionModel = dataProvider.getDescriptionModel()
        textModel.addDescriptionHandler(model: descriptionModel)
    }
    
    private func addLimit() {
        guard
            let textModel = model as? TextCreateTaskModel,
            let dataProvider = delegate
        else {
            return
        }
        
        let limitModel = dataProvider.getMinSymbolsModel()
        textModel.addLimitHandler(model: limitModel)
    }
    
    private func addDuration() {
        guard
            let timerModel = model as? TimerCreateTaskModel,
            let dataProvider = delegate
        else {
            return
        }
        
        let durationModel = dataProvider.getDurationModel()
        timerModel.addDurationHandler(duration: durationModel) { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .duration, delegate: nil)
        }
    }
    
    private func addWeekdayHandler() {
        let weekdayModels = delegate?.getWeekdayModels() ?? []
        model?.addWeekdayHandler(models: weekdayModels)
    }
    
    private func addNotificationHandler() {
        let models = delegate?.getNotificationModels() ?? []
        
        model?.addNotificationHandler(notificationModels: models, switchCallback: { isOn in
            print("Is active = \(isOn)")
        }, timerCallback: { [weak self] notifDelegate in
            print("Timer callback")
            self?.delegate?.showTimePicker(pickerType: .notification, delegate: notifDelegate)
        })
    }
    
    // тут нужно обновить все хендлеры перед перезагрузкой таблицы с обновленными данными в моделях
    private func fullUpdate() {
        
        addDuration()
    }
    
    func getModel() -> [AnyObject] {
        fullUpdate()
        return model?.prepare() ?? []
    }
    
}
