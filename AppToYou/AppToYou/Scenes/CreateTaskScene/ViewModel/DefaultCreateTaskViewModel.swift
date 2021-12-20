import Foundation
import XCoordinator


class DefaultCreateTaskViewModel: CreateTaskViewModel, CreateTaskViewModelInput, CreateTaskViewModelOutput {
    private(set) var router: UnownedRouter<TasksRoute>

    
    private lazy var constructor: DefaultTaskModel = {
        return DefaultTaskModel(delegate: self)
    }()

    weak var notificationDelegate: TaskNoticationDelegate?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())


    init(router: UnownedRouter<TasksRoute>) {
        self.router = router
        update()
    }

    func notificationTimePicked(_ time: NotificationTime) {
        guard let notificationDelegate = notificationDelegate else {
            return
        }
        let model = NotificationTaskTimeModel(notificationTime: time)
        notificationDelegate.notificationDidAdd(model)
        updateState()
    }
    
    func durationTimePicked(_ time: DurationTime) {
        // обработка получения происходит в TimerCreateTaskViewModel
    }

    func saveDidTapped() {
        validate()
    }
    
    func validate() {
        print(#function)
        print()
        
        let model = constructor.model
        
        let name = model.nameModel.fieldModel.value
        print("name = \(name)")
        
        let freq = model.frequencyModel.value.frequency
        print("freq = \(freq)")
        
        let days = model.weekdayModel?.weekdayModels.compactMap { $0 }
        let daysResult = days?.map { $0.isSelected }
            .map { $0 ? "1" : "0" }
            .joined()
        print("daysResult = \(daysResult)")
        
        let onceDate = model.selectDateModel?.date.value
        print("Once date = \(onceDate)")
        
        let period = model.periodModel
        let start = period?.start.value
        let end = period?.end.value
        let isInfinite = period?.isInfiniteModel.isSelected
        print("start = \(start)")
        print("end = \(end)")
        print("isInfinite = \(isInfinite)")
        
        let notifcations = model.notificationModel.notificationModels
        notifcations.forEach { print("\($0.hourModel.value) : \($0.minModel.value)") }
        
        let sanction = model.sanctionModel.model.value
        print("sanction = \(sanction)")
//
//        if let repeatModel = model as? RepeatCreateTaskModel {
//            let name = repeatModel.nameModel.fieldModel.value
//        }
    }
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        data.value = constructor.getModels()
    }
    
    /**
     Обновление внутри ячеек.
     
     Приводит к вызову tableView.beginUpdates()
     */
    func updateState() {
        updatedState.value = ()
    }

}

extension DefaultCreateTaskViewModel: DefaultTaskCreationDelegate {
    
    func showTimePicker(pickerType: TimePickerType, delegate: TaskNoticationDelegate?) {
        notificationDelegate = delegate
        router.trigger(.timePicker(type: pickerType))
    }
    
    func getNameModel() -> TextFieldModel {
        // TODO: - получать имя из модели задачи
        
        return .init(value: String(), placeholder: R.string.localizable.forExampleDoExercises())
    }
    
    func getFrequncy() -> FrequncyValueModel {
        // TODO: - получать частоту из модели задачи
        
        return FrequncyValueModel()
    }
    
    func getPeriodModel() -> TaskPeriodModel {
        // TODO: - получать isSelected, даты из модели задачи
        
        let isInfiniteModel = TitledCheckBoxModel(title: "Бесконечная длительность курса", isSelected: false)
        return TaskPeriodModel(isInfiniteModel: isInfiniteModel, start: DateFieldModel(), end: DateFieldModel(value: nil))
    }
    
    func getSanctionModel() -> NaturalNumberFieldModel {
        return NaturalNumberFieldModel()
    }
    
    func getNotificationModels() -> [NotificationTaskTimeModel] {
        // TODO: - получать нотификации из модели задачи
        
        let model = NotificationTaskTimeModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                              minModel: TimeBlockModelFactory.getMinModel())
        return [model]
    }
    
    func getWeekdayModels() -> [WeekdayModel] {
        // TODO: - получать модели из модели задачи или создавать новые из календаря
        let calendar = Calendar.autoupdatingCurrent
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let bound = calendar.firstWeekday - 1
        let orderedSymbols = weekdaySymbols[bound...] + weekdaySymbols[..<bound]
        
        return orderedSymbols.map { WeekdayModel(title: $0) }
    }
    
    func getOnceDateModel() -> DateFieldModel {
        // TODO: - получать дату из модели задачи
        
        return DateFieldModel()
    }
    
}
