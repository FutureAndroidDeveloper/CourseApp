import Foundation


class UserEditTimerCourseTaskConstructor: UserEditCourseTaskConstructor {
    
    let userEditTimerTaskModel: UserEditTimerCourseTaskModel
    private weak var dataSource: TimerTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: UserEditTimerCourseTaskModel) {
        self.userEditTimerTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    override func construct() {
        super.construct()
        
        guard let dataSource = dataSource else {
            return
        }
        addDuration(dataSource)
    }
    
    func setTimerDataSource(dataSource: TimerTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    private func addDuration(_ dataProvider: TimerTaskDataSource) {
        let (duration, lock) = dataProvider.getDurationModel()
        let isLocked = lock?.isLocked ?? false
        
        userEditTimerTaskModel.timerModel.addDurationHandler(duration: duration, lockModel: nil) {[weak self] in
            self?.delegate?.showTimePicker(pickerType: .userTaskDuration, delegate: nil)
        }
        userEditTimerTaskModel.timerModel.durationModel.updateActiveState(isLocked)
    }
    
}
