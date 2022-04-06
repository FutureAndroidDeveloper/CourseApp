import Foundation


protocol TimerTaskDataSource: CheckboxTaskDataSource {
    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?)
}


class TimerTaskConstructor: CheckboxTaskConstructor {
    
    let timerModel: TimerCreateTaskModel
    private weak var dataSource: TimerTaskDataSource?
    
    init(mode: CreateTaskMode, model: TimerCreateTaskModel) {
        self.timerModel = model
        super.init(mode: mode, model: model)
    }
    
    func setDataSource(dataSource: TimerTaskDataSource?) {
        super.setDataSource(dataSource: dataSource)
        self.dataSource = dataSource
    }

    override func construct() {
        super.construct()

        guard let dataSource = dataSource else {
            return
        }
        addDuration(dataSource)
    }
    
    private func addDuration(_ dataProvider: TimerTaskDataSource) {
        let (durationModel, lockModel) = dataProvider.getDurationModel()
        timerModel.addDurationHandler(duration: durationModel, lockModel: lockModel) { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .userTaskDuration, delegate: nil)
        }
    }

}
