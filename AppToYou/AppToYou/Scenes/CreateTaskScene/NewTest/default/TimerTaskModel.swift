import Foundation


protocol TimerTaskCreationDelegate: DefaultTaskCreationDelegate {
    func getDurationModel() -> (field: TaskDurationModel, lock: LockButtonModel?)
}

class TimerTaskModel<DataProvider>: DefaultTaskModel<TimerCreateTaskModel, DataProvider> where DataProvider: TimerTaskCreationDelegate {

    override func construct() {
        super.construct()

        guard let dataProvider = delegate else {
            return
        }
        addDuration(dataProvider)
    }
    
    private func addDuration(_ dataProvider: TimerTaskCreationDelegate) {
        let (durationModel, lockModel) = dataProvider.getDurationModel()
        model.addDurationHandler(duration: durationModel, lockModel: lockModel) { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .duration, delegate: nil)
        }
    }
    
}
