import Foundation


protocol DefaultTaskCreationDataSource: AnyObject {
    func getNameModel() -> TextFieldModel
    func getFrequncy() -> FrequncyValueModel
    func getOnceDateModel() -> DateFieldModel
    func getWeekdayModels() -> [WeekdayModel]
    func getPeriodModel() -> TaskPeriodModel
    func getNotificationModels() -> (models: [NotificationTaskTimeModel], isEnabled: Bool)
    func getSanctionModel() -> (model: NaturalNumberFieldModel, isEnabled: Bool)
}

protocol DefaultTaskCreationDelegate: DefaultTaskCreationDataSource {
    func update()
    func updateState()
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?)
}



class DefaultTaskModel<DataModel: DefaultCreateTaskModel, DataProvider>: TaskCreation where DataProvider: DefaultTaskCreationDelegate {
    
    var model: DataModel
    weak var delegate: DataProvider?
    
    init(delegate: DataProvider) {
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
        addPeriod(dataProvider)
        addNotificationHandler(dataProvider)
        addSanction(dataProvider)
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
        
        model.addFrequency(frequencyValue) { [weak self] frequency in
            self?.model.removeWeekdayHandler()
            self?.model.removeSelectDateHandler()
            self?.addPeriod(dataProvider)
            
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
        let (sanctionModel, isEnabled) = dataProvider.getSanctionModel()
        
        model.addSanction(model: sanctionModel, isEnabled: isEnabled) { [weak self] in
            print("Question")
        }
    }
    
    private func addselectDate(_ dataProvider: DefaultTaskCreationDelegate) {
        let onceDate = dataProvider.getOnceDateModel()
        model.addSelectDateHandler(date: onceDate)
    }
    
    private func addWeekdayHandler(_ dataProvider: DefaultTaskCreationDelegate) {
        let weekdayModels = dataProvider.getWeekdayModels()
        model.addWeekdayHandler(models: weekdayModels)
    }
    
    func getModel() -> DefaultCreateTaskModel {
        return model
    }
    
}
