import Foundation


protocol TaskCreationDelegate: AnyObject {
    func update()
    
    func updateState()
    func showTimePicker(delegate: TaskNoticationDelegate)
    
    func getNameModel() -> TextFieldModel
    
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
        
        switch type {
        case .CHECKBOX:
            model = DefaultCreateTaskModel()
        case .TEXT:
            let textModel = TextCreateTaskModel()
            textModel.addDescriptionHandler { description in
//                self.task.taskDescription = description
            }
            textModel.addLimitHandler()
            
            model = textModel
        case .TIMER:
            let timerModel = TimerCreateTaskModel()
            timerModel.addDurationHandler()
            
            model = timerModel
        case .RITUAL:
            let repeatModel = RepeatCreateTaskModel()
            repeatModel.addCountHandler()
            
            model = repeatModel
        }
        
        let nameModel = delegate?.getNameModel() ?? .init()
        model?.addNameHandler(nameModel)
        
        model?.addFrequencyHandler { [weak self] frequency in
            print(frequency)
            
            if frequency == .ONCE {
                self?.model?.addSelectDateHandler()
                self?.model?.removeWeekdayHandler()
                self?.model?.removePeriodHandler()
            } else if frequency == .CERTAIN_DAYS {
                self?.addWeekdayHandler()
                self?.addPeriod()
                self?.model?.removeSelectDateHandler()
            }
            else {
                self?.model?.removeWeekdayHandler()
                self?.model?.removeSelectDateHandler()
                self?.addPeriod()
            }
            
            self?.updateAndSync()
//            self.task.frequencyType = frequency
        }
        
        addPeriod()
        addNotificationHandler()
                
        model?.addSanctionHandler(callbackText: { sanction in
            print(sanction)
//            self.task.taskSanction = Int(sanction) ?? -1
        }, questionCallback: {
            print("Question Handler")
        })
        
        model?.addSaveHandler { [weak self] in
            print("Save")
            self?.delegate?.update()
            // validate + после валидации при необходимости обновить модель ячеек с указанием ошибок
            // при успешной валидации отправить запрос на сервер
            // при успешном выполнении запроса, сохранить в бд
        }
    }
    
    private func addPeriod() {
        model?.addPeriodHandler(startPicked: { start in
            print(start)
//            self.task.startDate = start ?? "N/A"
        }, endPicked: { end in
            print(end)
//            self.task.endDate = end ?? "N/A"
        })
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
            self?.delegate?.showTimePicker(delegate: notifDelegate)
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
    
    func getModel() -> [AnyObject] {        
        return model?.prepare() ?? []
    }
    
}
