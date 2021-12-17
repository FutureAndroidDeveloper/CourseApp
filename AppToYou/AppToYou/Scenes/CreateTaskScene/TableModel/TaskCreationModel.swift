import Foundation


protocol TaskCreationDelegate: AnyObject {
    func update()
    
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
    
    func getNameModel() -> TextFieldModel
    
    func getFrequncy() -> ATYFrequencyTypeEnum
    func getOnceDateModel() -> DateFieldModel
    func getPeriodModel() -> (start: DateFieldModel, end: DateFieldModel)
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
    
    private var model: DefaultCreateTaskModel?
    
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
        
        addPeriod()
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
            
            if newFrequency == .ONCE {
                self?.addselectDate()
                self?.model?.removeWeekdayHandler()
                self?.model?.removePeriodHandler()
            } else if newFrequency == .CERTAIN_DAYS {
                self?.addWeekdayHandler()
                self?.addPeriod()
                self?.model?.removeSelectDateHandler()
            }
            else {
                self?.model?.removeWeekdayHandler()
                self?.model?.removeSelectDateHandler()
                self?.addPeriod()
            }
            
            self?.addFrequency(initial: newFrequency)
            self?.updateAndSync()
        }
    }
    
    private func addPeriod() {
        guard let dataProvider = delegate else {
            return
        }
        
        let periodModel = dataProvider.getPeriodModel()
        model?.addPeriodHandler(start: periodModel.start, end: periodModel.end)
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
    
    /**
     Обновление модели таблицы.
     
     Также получает обновленную модель напоминаний о задаче.
     */
    private func updateAndSync() {
        addNotificationHandler()
        delegate?.update()
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
