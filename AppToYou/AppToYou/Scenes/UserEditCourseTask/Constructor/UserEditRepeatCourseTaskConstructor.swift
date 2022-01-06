import Foundation


class UserEditRepeatCourseTaskConstructor: UserEditCourseTaskConstructor {
    
    let userEditRepeatTaskModel: UserEditRepeatCourseTaskModel
    private weak var dataSource: CounterTaskDataSource?
    
    
    init(mode: CreateTaskMode, model: UserEditRepeatCourseTaskModel) {
        self.userEditRepeatTaskModel = model
        super.init(mode: mode, model: model)
    }
    
    override func construct() {
        super.construct()
        
        guard let dataSource = dataSource else {
            return
        }
        addCounterModel(dataSource)
    }
    
    func setRepeatDataSource(dataSource: CounterTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    private func addCounterModel(_ dataProvider: CounterTaskDataSource) {
        let (field, lock) = dataProvider.getCounterModel()
        let isLocked = lock?.isLocked ?? false
        
        userEditRepeatTaskModel.repeatModel.addCounter(model: field, lockModel: nil)
        userEditRepeatTaskModel.repeatModel.countModel.updateActiveState(isLocked)
    }
    
}
