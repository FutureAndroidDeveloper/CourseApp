import Foundation


protocol TaskCreationDelegate: AnyObject {
    func update()
    
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
    
    func getNameModel() -> TextFieldModel
    func getFrequncy() -> ATYFrequencyTypeEnum
    func getOnceDateModel() -> DateFieldModel
    func getWeekdayModels() -> [WeekdayModel]
    func getPeriodModel() -> TaskPeriodModel
    func getNotificationModels() -> [NotificationTaskTimeModel]
    func getSanctionModel() -> NaturalNumberFieldModel
    
    func getDescriptionModel() -> PlaceholderTextViewModel
    func getMinSymbolsModel() -> NaturalNumberFieldModel
    
    func getDurationModel() -> TaskDurationModel
    
    func getCounterModel() -> NaturalNumberFieldModel
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
            model = repeatModel
            addCounter()
        }
        
        let nameModel = dataProvider.getNameModel()
//        model?.addNameHandler(nameModel)
        
        let frequency = dataProvider.getFrequncy()
        addFrequency(initial: frequency)
        
        updatePeriod()
        addNotificationHandler()
                
//        model?.addSanctionHandler(callbackText: { sanction in
//            print(sanction)
////            self.task.taskSanction = Int(sanction) ?? -1
//        }, questionCallback: {
//            print("Question Handler")
//        })
    }
    
    private func addselectDate() {
        guard let dataProvider = delegate else {
            return
        }
        
        let onceDate = dataProvider.getOnceDateModel()
        model?.addSelectDateHandler(date: onceDate)
    }
    
    private func addFrequency(initial frequency: ATYFrequencyTypeEnum) {
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
    }
    
    private func addDuration() {
    }
    
    private func addCounter() {
    }
    
    private func addWeekdayHandler() {
        let weekdayModels = delegate?.getWeekdayModels() ?? []
        model?.addWeekdayHandler(models: weekdayModels)
    }
    
    private func addNotificationHandler() {
        let models = delegate?.getNotificationModels() ?? []
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
