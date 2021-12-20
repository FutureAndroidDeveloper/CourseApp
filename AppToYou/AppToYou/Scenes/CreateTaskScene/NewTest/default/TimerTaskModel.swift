import Foundation


protocol TimerTaskCreationDelegate: DefaultTaskCreationDelegate {
    func getDurationModel() -> TaskDurationModel
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
        let durationModel = dataProvider.getDurationModel()
        model.addDurationHandler(duration: durationModel) { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .duration, delegate: nil)
        }
    }
    
}
